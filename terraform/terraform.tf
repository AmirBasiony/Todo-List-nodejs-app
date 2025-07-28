terraform {
  backend "s3" {
    bucket       = "terraform-infra-bucket-todo-app"
    key          = "infra/terraform.tfstate"
    region       = "us-east-1"
    encrypt      = true
    use_lockfile = true
  }
}

provider "aws" {
  region = var.aws_region
}