# Output the ID of the created subnet
output "subnet_id" {
  value = aws_subnet.this.id                           # Outputs the subnet ID after creation
}