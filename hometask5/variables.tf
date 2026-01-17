variable "org" {
  type = string
  description = "Organization"
  default = "netflix"
}
variable "dep" {
  type = string
  description = "Department"
  default = "it"
}
variable "bu" {
  type = string
  description = "Domain/Business Unit"
  default = "ai"
}
variable "env" {
  type = string
  description = "Environment"
  default = "dev"
}
variable "region" {
  type = string
  description = "Provider Region"
  default = "ue2"
}
variable "tier" {
  type = string
  description = "Tier"
  default = "frontend"
}


variable "tags" {
  description = "common tags"
  type        = map(string)
  default = {
    "Project"    = "hometask5"
    "Managed_by" = "terraform"
  }
}