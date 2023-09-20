resource "aws_s3_bucket" "terraform-state" {
  bucket        = "pbl18"
  force_destroy = true
}
resource "aws_s3_bucket_versioning" "version" {
  bucket = aws_s3_bucket.terraform-state.id
  versioning_configuration {
    status = "Enabled"
  }
}
resource "aws_s3_bucket_server_side_encryption_configuration" "first" {
  bucket = aws_s3_bucket.terraform-state.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_dynamodb_table" "terraform_locks" {
  name         = "terraform-locks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
}

module "VPC" {
  source                              = "./modules/networking"
  region                              = var.region
  vpc_cidr                            = var.vpc_cidr
  enable_dns_support                  = var.enable_dns_support
  enable_dns_hostnames                = var.enable_dns_hostnames
  enable_classiclink                  = var.enable_classiclink
  preferred_number_of_public_subnets  = var.preferred_number_of_public_subnets
  preferred_number_of_private_subnets = var.preferred_number_of_private_subnets
  private_subnets                     = [for i in range(1, 8, 2) : cidrsubnet(var.vpc_cidr, 8, i)]
  public_subnets                      = [for i in range(2, 5, 2) : cidrsubnet(var.vpc_cidr, 8, i)]
}

#Module for Application Load balancer, this will create Extenal Load balancer and internal load balancer
module "ALB" {
  source        = "./modules/alb"
  vpc_id        = module.VPC.vpc_id
  public-sg     = module.security.ext-alb-sg
  private-sg    = module.security.int-alb-sg
  public-sbn-1  = module.VPC.public_subnets-1
  public-sbn-2  = module.VPC.public_subnets-2
  private-sbn-1 = module.VPC.private_subnets-1
  private-sbn-2 = module.VPC.private_subnets-2

  ip_address_type = "ipv4"
}

module "security" {
  source = "./modules/Security"
  vpc_id = module.VPC.vpc_id
}

module "RDS" {
  source          = "./modules/rds"
  db-password     = var.master-password
  db-username     = var.master-username
  db-sg           = [module.security.datalayer-sg]
  private_subnets = [module.VPC.private_subnets-3, module.VPC.private_subnets-4]
}

# The Module creates instance
module "ec2" {
  source          = "./modules/ec2"
  ami             = var.aws_ami_id
  subnets-compute = module.VPC.public_subnets-1
  sg-compute      = [module.security.webserver-sg]
  keypair         = var.keypair
}

module "vpc_endpoint" {
  source       = "./modules/vpc-endpoint"
  vpc_id       = module.VPC.vpc_id
  service_name = base64decode(null)
  vpc_endpoint = [module.security.vpc_endpoint-sg]
}