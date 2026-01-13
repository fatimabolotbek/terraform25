variable "tags" {
  description = "command tage"
  type =  map(string)
  default = {
    "Name" = "homework3-vpc"
    "Environment" = "dev"
  }
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}
# variable "vpc_cider_tr" {
#     default = "0.0.0.0/0"
  
# }

# variable "public_subnet_cidrs" {
#   default = ["10.0.0.0/24", "10.0.1.0/24", "10.0.2.0/24"]
# }

# variable "azs" {
#    default = ["us-east-2a", "us-east-2b", "us-east-2c"]
# }

# variable "private_subnet_cidr"{
#     default = ["10.0.10.0/24", "10.0.11.0/24", "10.0.12.0/24"]
# }