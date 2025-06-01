provider "aws" {
  region = "eu-north-1"                             # Sets the AWS region to Stockholm (eu-north-1)
}

module "vpc" {
  source     = "./modules/vpc"                      # Path to VPC module
  cidr_block = "10.0.0.0/16"                         # CIDR block for the VPC
  name       = "stockholm-vpc"                      # Name tag prefix for resources in the VPC
}

module "subnet" {
  source            = "./modules/subnet"            # Path to subnet module
  vpc_id            = module.vpc.vpc_id             # Reference VPC ID from the vpc module
  cidr_block        = "10.0.0.0/24"                  # CIDR block for the subnet
  availability_zone = "eu-north-1a"                 # Availability zone for the subnet
  name              = "stockholm-subnet"            # Name tag for the subnet
}

module "SG" {
  source = "./modules/SG"                           # Path to security group module
  vpc_id = module.vpc.vpc_id                        # Attach SG to the created VPC
  name   = "http-sg"                                # Name for the SG
}

module "ec2" {
  source            = "./modules/ec2"               # Path to EC2 module
  ami               = "ami-00f34bf9aeacdf007"       # Amazon Linux 2 AMI (Stockholm)
  instance_type     = "t3.micro"                    # EC2 instance type
  subnet_id         = module.subnet.subnet_id       # Subnet to launch EC2 in
  security_group_id = module.SG.sg_id               # ✅ Fixed: use SG module output
  user_data_file    = "${path.module}/user-data.txt"# ✅ Fixed: user-data script file
  instance_name     = "stockholm-web"               # Tag for instance name
}

resource "aws_route_table_association" "public_subnet_association" {
  subnet_id      = module.subnet.subnet_id          # Associate route table with the subnet
  route_table_id = module.vpc.public_route_table_id # Reference route table from vpc module
}