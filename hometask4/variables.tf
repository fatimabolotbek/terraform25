variable "tags" {
  description = "common tags"
  type        = map(string)
  default = {
    "Project"     = "aws-homework-4"
    "Environment" = "dev"
  }
}



variable "vpc_cidr_block" {
  type        = string
  description = "VPC CIDR block"
  default     = "10.0.0.0/16"
}




variable "public_subnet_cidrs" {
  type    = list(string)
  default = ["10.0.0.0/24", "10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidrs" {
  type    = list(string)
  default = ["10.0.3.0/24", "10.0.4.0/24", "10.0.5.0/24"]
}

variable "azs" {
  type    = list(string)
  default = ["us-east-2a", "us-east-2b", "us-east-2c"]
}






variable "vpc_cidr" {
  description = "VPC CIDR"
  type        = string
  default     = "10.0.0.0/16"
}

variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-2"
}