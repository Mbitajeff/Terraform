terraform {
  backend "s3" {
    bucket         = "terraform-state-day6-992382477563"
    key            = "environments/production/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-state-locks"
    encrypt        = true
  }
}
