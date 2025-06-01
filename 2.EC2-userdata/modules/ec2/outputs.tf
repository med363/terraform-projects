output "instance_id" {
  description = "The ID of the EC2 instance"                   # Description of this output value
  value       = aws_instance.this.id                           # Outputs the EC2 instance ID
}

output "public_ip" {
  value = aws_instance.this.public_ip                          # Outputs the public IP of the EC2 instance
}

output "public_dns" {
  value = aws_instance.this.public_dns                         # Outputs the public DNS name of the EC2 instance
}