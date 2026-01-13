variable "public_subnet_cidrs" {
  description = "Public subnet CIDR blocks"
  type        = list(string)
  default     = [
    "10.0.0.0/24",
    "10.0.1.0/24",
    "10.0.2.0/24"
  ]
}

variable "private_subnet_cidrs" {
  description = "Private subnet CIDR blocks"
  type        = list(string)
  default     = [
    "10.0.3.0/24",
    "10.0.4.0/24",
    "10.0.5.0/24"
  ]
}

variable "azs" {
  description = "Availability Zones"
  type        = list(string)
  default     = [
    "us-east-2a",
    "us-east-2b",
    "us-east-2c"
  ]
}


variable "tags" {
  description = "command tage"
  type =  map(string)
  default = {
    "Name" = "homework3-vpc"
    "Environment" = "dev"
  }
}

variable "vpc_cidr" {
  description = "VPC CIDR"
  type        = string
  default     = "10.0.0.0/16"
}

variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}