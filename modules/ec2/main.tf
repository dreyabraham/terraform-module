#create instance for sonbarqube
resource "aws_instance" "windows" {
  ami                         = var.aws_ami_id
  instance_type               = "t2.medium"
  subnet_id                   = var.subnets-compute
  vpc_security_group_ids      = var.sg-compute
  associate_public_ip_address = true
  key_name                    = var.keypair


   tags = merge(
    var.tags,
    {
      Name = "windows"
    },
  )
}