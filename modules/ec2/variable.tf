variable "subnets-compute" {
    description = "public subnetes for compute instances"
}

variable "sg-compute" {
    description = "security group for compute instances"
}

variable "keypair" {
    type = string
    description = "keypair for instances"
}

variable "tags" {
  description = "A mapping of tags to assign to all resources."
  type        = map(string)
  default     = {}
}

variable "aws_ami_id" {
    type = string
    description = "id for ami"
    default = "ami-05705f8465db448b7"
}