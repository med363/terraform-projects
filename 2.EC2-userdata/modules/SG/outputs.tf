output "sg_id" {
  description = "The ID of the created security group"  # Description of the output value
  value       = aws_security_group.http_sg.id           # Outputs the security group ID
}