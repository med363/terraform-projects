provider "aws" {
  region = "eu-north-1"
}

module "vpc" {
    source = "./modules/vpc"
    cidr_block = "10.0.0.0/16"
    name = "stockholm-vpc"
  
}

module "subnet" {
    source = "./modules/subnet"
    vpc_id = module.vpc.vpc_id
    cidr_block = "10.0.0.0/24"
    availability_zone = "eu-north-1a"
    name = "stockholm-subnet"
  
}

module "SG" {
    source = "./modules/SG"
    vpc_id = module.vpc.vpc_id
    name = "http-sg"
  
}

module "ec2" {
  source             = "./modules/ec2"
  ami                = "ami-00f34bf9aeacdf007"
  instance_type      = "t3.micro"
  subnet_id          = module.subnet.subnet_id
  security_group_id  = module.SG.sg_id       # ✅ FIXED
  user_data_file     = "${path.module}/user-data.txt" # ✅ FIXED
  instance_name      = "stockholm-web"        # ✅ FIXED
}
#

resource "aws_route_table_association" "public_subnet_association" {
  subnet_id      = module.subnet.subnet_id
  route_table_id = module.vpc.public_route_table_id
}
