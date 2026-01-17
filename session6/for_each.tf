resource "aws_s3_bucket" "example" {
  for_each = var.buckets
  bucket = each.value.name
  object_lock_enabled = each.value.object_lock_enabled
  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}


variable "buckets" {
  description = "This is a map for bucket"
  type = map(any) // map of strings , bool, number
  default = {
    bucket-1 = {
        name = "terraform-session-ugs-fatima-1"
        object_lock_enabled = true
        acl = "private"
    }
    bucket-2 = {
        name = "terraform-session-ugs-fatima-2"
        object_lock_enabled = true
        acl = "public-read"
    }
  }
  
}