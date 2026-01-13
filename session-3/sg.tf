resource "aws_security_group" "main" {
  name        = "session3-sg"
  description = "This is sg for ec2 instance"


  tags = {
    Name = "session3-sg"
  }
}