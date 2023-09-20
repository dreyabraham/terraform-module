resource "aws_vpc_endpoint" "example_vpc_endpoint" {
  vpc_id = var.vpc_id
  service_name = "com.amazonaws.us-east-1.s3"
  security_group_ids = [var.security_group_ids]

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "*",
        Effect = "Allow",
        Resource = "*",
        Principal = "*",
      },
    ],
  })
}
