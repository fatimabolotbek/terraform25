resource "aws_instance" "first_ec2" {
  ami           = "ami-06f1fc9ae5ae7f31e"
  instance_type = "t2.micro"
  tags = {
    Name        = "first"
    Environment = "dev"
  }
}