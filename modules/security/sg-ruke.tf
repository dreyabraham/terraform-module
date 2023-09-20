resource "aws_security_group_rule" "inbound-alb-http" {
  from_port         = 80
  protocol          = "tcp"
  to_port           = 80
  type              = "ingress"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.ACS["ext-alb-sg"].id
}
 

resource "aws_security_group_rule" "inbound-alb-https" {
  from_port         = 443
  protocol          = "tcp"
  to_port           = 443
  type              = "ingress"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.ACS["ext-alb-sg"].id
}


resource "aws_security_group_rule" "inbound-ialb-https" {
  type                     = "ingress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.ACS["ext-alb-sg"].id
  security_group_id        = aws_security_group.ACS["int-alb-sg"].id
}
  # security group for webservers, to have access only from the internal load balancer and bastion instance

resource "aws_security_group_rule" "inbound-web-https" {
  type                     = "ingress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.ACS["int-alb-sg"].id
  security_group_id        = aws_security_group.ACS["webserver-sg"].id
}

resource "aws_security_group_rule" "inbound-mysql-webserver" {
  type                     = "ingress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.ACS["webserver-sg"].id
  security_group_id        = aws_security_group.ACS["datalayer-sg"].id
}