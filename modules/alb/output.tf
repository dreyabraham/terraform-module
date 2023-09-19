output "nginx-tgt" {
  description = "External Load balancaer target group"
  value       = aws_lb_target_group.webserver-tgt.arn
}


output "wordpress-tgt" {
  description = "wordpress target group"
  value       = aws_lb_target_group.webapp-tgt.arn
}