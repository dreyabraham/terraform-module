resource "aws_vpc_endpoint" "my_vpc_endpoint" {
  vpc_id       = var.vpc_id
  service_name = var.service_name
  security_group_ids = var.vpc_endpoint
}