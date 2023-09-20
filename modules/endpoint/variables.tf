variable "vpc_id" {
  description = "The ID of the VPC where the endpoint will be created."
}

variable "security_group_ids" {
  description = "A list of security group IDs to associate with the endpoint."
  type        = list(string)
}
