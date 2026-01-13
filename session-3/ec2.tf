resource "aws_instance" "main" {
  ami           = data.aws_ami.amazon_linux_23.id
  instance_type = var.instance_type
  vpc_security_group_ids = [aws_security_group.main.id]
  tags = var.tags
}