data "terraform_remote_state" "hometask5" {
  backend = "s3"
  config = {
    bucket = "session-s3-locking"
    key    = "hometask5/terraform.tfstate"
    region = "us-east-2"
  }
}
