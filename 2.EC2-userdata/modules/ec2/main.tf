resource "aws_instance" "this" {
  ami                         = var.ami                         # AMI ID to use for the instance, passed as a variable
  instance_type               = var.instance_type               # EC2 instance type (e.g., t2.micro), from variable
  subnet_id                   = var.subnet_id                   # Subnet ID where the instance will be launched
  vpc_security_group_ids      = [var.security_group_id]         # List of security group IDs (single value used here)
  user_data                   = file(var.user_data_file)        # Startup script from a file (user-data)
  associate_public_ip_address = true                            # Assign a public IP to the instance

  tags = {
    Name = var.instance_name                                    # Tag the instance with a Name, from variable
  }
}