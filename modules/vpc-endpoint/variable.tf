variable "vpc_id" {
  description = "The ID of the VPC in which to create the VPC endpoint"
}

variable "service_name" {
  description = "The name of the AWS service for the VPC endpoint (e.g., com.amazonaws.vpce.us-east-1.vpce-svc-xxxxxxxxxx)"
}

variable "vpc_endpoint" {
    description = "security group for vpc endpoint"
}