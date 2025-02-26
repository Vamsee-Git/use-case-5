terraform {
  backend "s3" {
    bucket         = "my-terraform-state-bucket-two-tier-vamsee"
    key            = "terraform/statefile_lambda"
    region         = "ap-south-1"
  }
}
