resource "aws_instance" "this" {
  ami                         = var.ami
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = [var.security_group_id]
  user_data                   = file(var.user_data_file)
  associate_public_ip_address = true

  tags = {
    Name = var.instance_name
  }
}
