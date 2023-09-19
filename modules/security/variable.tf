variable "security_groups" {
  description = "List of security groups to create"
  type        = list(object({
    name        = string
    description = string
    vpc_id      = string
    ingress_rules = list(object({
      from_port   = number
      to_port     = number
      protocol    = string
      cidr_blocks = list(string)
      
    }))
  }))
}
