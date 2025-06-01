# Variable for the VPC CIDR block
variable "cidr_block" {
}

# Variable for naming resources
variable "name" {
  description = "Name prefix for resources"     # Helpful for consistent naming (e.g., myapp -> myapp-igw)
  type        = string
}