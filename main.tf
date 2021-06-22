provider "aws" {
  region = "ap-northeast-2"
}

terraform {
  backend "s3" {
    bucket = "GitOps-Terraform"
    key = "./terraform.tfstate"
    region = "ap-northeast-2"
    encrypt = true
    aws_dynamodb_talble = "terraform_lock"
  }
}

resource "aws_s3_bucket" "GitOps_Terraform" {
  bucket = "GitOps-Terraform"
  force-destroy = true
  versioning {
    enabled = true
  }
}

resource "aws_dynamodb_talble" "GitOps_dyanmo" {
  hash_key = "LockID"
  name = "terraform_lock"
  read_capacity = 1
  write_capacity = 1

  atrribute {
    name = "LockID"
    type = "S"
  }
}