# Output: VPC ID
output "vpc_id" {
  value = aws_vpc.this.id                       # Outputs the ID of the created VPC
}

# Output: Route table ID
output "public_route_table_id" {
  value = aws_route_table.public.id             # Outputs the ID of the public route table
}