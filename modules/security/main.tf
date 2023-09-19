# create all security groups dynamically
resource "aws_security_group" "ACS" {
  count = length(var.security_groups)

  name        = var.security_groups[count.index].name
  description = var.security_groups[count.index].description
  vpc_id      = var.security_groups[count.index].vpc_id

  security_groups = [
    {
      name        = "ext-alb-sg"
      description = "Web Security Group"
      vpc_id      = aws_vpc.main.id
      ingress_rules = [
        {
          from_port   = 80
          to_port     = 80
          protocol    = "tcp"
          cidr_blocks = ["0.0.0.0/0"]
        },
        {
          from_port   = 443
          to_port     = 443
          protocol    = "tcp"
          cidr_blocks = ["0.0.0.0/0"]
        }
      ]
    },
    {
      name        = "int-alb-sg"
      description = "Database Security Group"
      vpc_id      = aws_vpc.main.id
      ingress_rules = [
        {
          from_port   = 443
          to_port     = 443
          protocol    = "tcp"
          source_security_group_id = aws_security_group.ACS["ext-alb-sg"].id
          security_group_id        = aws_security_group.ACS["int-alb-sg"].id
        }
      ]
    },
    {
      name        = "webserver-sg"
      description = "Application Security Group"
      vpc_id      = aws_vpc.main.id
      ingress_rules = [
        {
          from_port   = 443
          to_port     = 443
          protocol    = "tcp"
          source_security_group_id = aws_security_group.ACS["int-alb-sg"].id
          security_group_id        = aws_security_group.ACS["webserver-sg"].id
        }
      ]
    },
    
     {
      name        = "webserver-sg"
      description = "Application Security Group"
      vpc_id      = aws_vpc.main.id
      ingress_rules = [
        {
          from_port   = 22
          to_port     = 22
          protocol    = "tcp"
          cidr_blocks = ["0.0.0.0/0"]
        }
      ]
    },

    {
      name        = "datalayer-sg"
      description = "Application Security Group"
      vpc_id      = aws_vpc.main.id
      ingress_rules = [
        {
          from_port   = 3306
          to_port     = 3306
          protocol    = "tcp"
          source_security_group_id = aws_security_group.ACS["webserver-sg"].id
          security_group_id        = aws_security_group.ACS["datalayer-sg"].id
        }
      ]
    },
  ]
}

 
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    var.tags,
    {
      Name = each.value.name
    },
  )