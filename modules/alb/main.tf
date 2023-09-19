resource "aws_lb" "ext-alb" {
  name            = var.name
  internal        = false
  security_groups = [var.public-sg]

  subnets = [var.public-sbn-1,
  var.public-sbn-2, ]

  tags = merge(
    var.tags,
    {
      Name = var.name
    },
  )

  ip_address_type    = var.ip_address_type
  load_balancer_type = var.load_balancer_type
}

#--- create a target group for the external load balancer
resource "aws_lb_target_group" "webserver-tgt" {
  health_check {
    interval            = 10
    path                = "/healthstatus"
    protocol            = "HTTPS"
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
  }
  name        = "webserver=tgt"
  port        = 443
  protocol    = "HTTPS"
  target_type = "instance"
  vpc_id      = var.vpc_id
}

resource "aws_lb" "ialb" {
  name     = "ialb"
  internal = true

  security_groups = [var.private-sg]

  subnets = [var.private-sbn-1,
  var.private-sbn-2, ]

    tags = merge(
    var.tags,
    {
      Name = "ACS-int-alb"
    },
  )

  ip_address_type    = var.ip_address_type
  load_balancer_type = var.load_balancer_type
}

# --- target group  for wordpress -------

resource "aws_lb_target_group" "webapp-tgt" {
  health_check {
    interval            = 10
    path                = "/healthstatus"
    protocol            = "HTTPS"
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
  }

  name     = "webapp-tgt"
   port        = 443
  protocol    = "HTTPS"
  target_type = "instance"
  vpc_id      = var.vpc_id
  }