terraform {
  backend "s3" {
    bucket         = "session-s3-locking"
    key            = "hometask4/terraform.tfstate"
    region         = "us-east-2"
    encrypt        = true
    
  }
}