resource "aws_vpc" "this" {
  cidr_block           = var.cidr_block         # CIDR block for the VPC (e.g., 10.0.0.0/16)
  enable_dns_support   = true                   # Enable internal DNS support within the VPC
  enable_dns_hostnames = true                   # Allow instances to be assigned DNS hostnames

  tags = {
    Name = var.name                             # Tag the VPC with a Name from the 'name' variable
  }
}

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id                      # Attach the Internet Gateway to the created VPC

  tags = {
    Name = "${var.name}-igw"                    # Tag the Internet Gateway with a name suffix "-igw"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id                      # Create a route table for the same VPC

  route {
    cidr_block = "0.0.0.0/0"                    # Route all outbound traffic (default route)
    gateway_id = aws_internet_gateway.this.id   # Route it through the Internet Gateway
  }

  tags = {
    Name = "${var.name}-public-rt"              # Tag the route table with a name suffix "-public-rt"
  }
}