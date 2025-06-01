resource "aws_subnet" "this" {
  vpc_id                  = var.vpc_id                  # ID of the VPC where this subnet will be created
  cidr_block              = var.cidr_block              # The CIDR block (IP range) assigned to this subnet
  map_public_ip_on_launch = true                        # ✅ Automatically assigns a public IP to instances launched in this subnet
  availability_zone       = var.availability_zone       # The specific availability zone where the subnet will reside

  tags = {
    Name = var.name                                     # Tag the subnet with a Name from a variable
  }
}
