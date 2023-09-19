variable "region" {
  default = "eu-west-1"
}

variable "vpc_cidr" {
  default = "172.16.0.0/16"
}

variable "enable_dns_support" {
  default = "true"
}

variable "enable_dns_hostnames" {
  default = "true"
}

variable "enable_classiclink" {
  default = "false"
}

variable "enable_classiclink_dns_support" {
  default = "false"
}

variable "preferred_number_of_public_subnets" {
  type        = number
  description = "Number of public subnets"
}

variable "preferred_number_of_private_subnets" {
  type        = number
  description = "Number of private subnets"
}

variable "name" {
  type    = string
  default = "windows"

}

variable "tags" {
  description = "A mapping of tags to assign to all resources."
  type        = map(string)
  default     = {}
}

variable "environment" {
  type        = string
  description = "Enviroment"
}

variable "ami" {
  type        = string
  description = "AMI ID for the launch template"
}


variable "keypair" {
  type        = string
  description = "key pair for the instances"
}

variable "account_no" {
  type        = number
  description = "the account number"
}


variable "master-username" {
  type        = string
  description = "RDS admin username"
}

variable "master-password" {
  type        = string
  description = "RDS master password"
}

variable "security_group_name" {
  type        = string
  description = "Name of security group - not required if create_sg is false"
}

variable "security_group_description" {
  type        = string
  description = "Description of security group"
}

variable "ingress_cidr_blocks" {
  type        = list(any)
  description = "List of IPv4 CIDR ranges to use on all ingress rules"
}

variable "ingress_rules" {
  type        = list(any)
  description = " List of ingress rules to create by name"
}

variable "ingress_with_cidr_blocks" {
  type        = list(any)
  description = "List of ingress rules to create where 'cidr_blocks' is used"
}

variable "egress_cidr_blocks" {
  type        = list(any)
  description = "List of IPv4 CIDR ranges to use on all egress rules"
}

variable "egress_rules" {
  type        = list(any)
  description = "List of egress rules to create by name"
}

variable "egress_with_cidr_blocks" {
  type        = list(any)
  description = "List of egress rules to create where 'cidr_blocks' is used"
}