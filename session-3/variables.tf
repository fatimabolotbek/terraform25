variable "instance_type" {
  description = "aws ec2 instance type"
  type =  string
  default = "t2.micro"
}


variable "tags" {
  description = "command tage"
  type =  map(string)
  default = {
    "Name" = "session3-instance"
    "Environment" = "dev"
  }
}