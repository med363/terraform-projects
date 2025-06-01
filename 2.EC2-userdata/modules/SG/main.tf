resource "aws_security_group" "http_sg" {
  name        = var.name                        # Name of the security group, taken from variable
  description = "Allow HTTP traffic"            # Description for the security group
  vpc_id      = var.vpc_id                      # VPC ID where the security group will be created

  ingress {
    from_port   = 80                            # Starting port of allowed incoming traffic (HTTP)
    to_port     = 80                            # Ending port (same as from_port for single port)
    protocol    = "tcp"                         # Protocol type (TCP for HTTP)
    cidr_blocks = ["0.0.0.0/0"]                 # Allow access from any IP (public access)
  }

  egress {
    from_port   = 0                             # Starting port of allowed outgoing traffic
    to_port     = 0                             # Ending port (0 means all)
    protocol    = "-1"                          # Protocol -1 means all protocols
    cidr_blocks = ["0.0.0.0/0"]                 # Allow all outbound traffic to any IP
  }

  tags = {
    Name = var.name                             # Tag the security group with a name
  }
}