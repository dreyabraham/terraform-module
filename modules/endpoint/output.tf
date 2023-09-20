output "endpoint_id" {
  description = "The ID of the created VPC endpoint."
  value       = aws_vpc_endpoint.example_vpc_endpoint.id
}
