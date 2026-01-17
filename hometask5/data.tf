data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = "session-s3-locking"
    key    = "hometask4/terraform.tfstate"
    region = "us-east-2"
  }
}


data "aws_ami" "amazon_linux_23" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}