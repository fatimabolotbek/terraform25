variable "zone_id" {
  default = "Z0438803V2R3XWGHS6VM"
}

variable "root_domain_name" {
  default = "phonedomain.net"
}

variable "tags" {
  description = "common tags"
  type        = map(string)
  default = {
    "Project"    = "hometask5"
    "Managed_by" = "terraform"
  }
}

variable "instance_type" {
  description = "aws ec2 instance type"
  type =  string
  default = "t2.micro"
}

variable "env" {
  description = "Environment"
  type        = string
  default     = "dev"
}