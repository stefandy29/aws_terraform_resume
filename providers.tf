terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  backend "s3" {
    bucket = "terraform-backup-keysersoze"
    key    = "state/terraform.tfstate"
    region = "ap-southeast-3"
  }
}

provider "aws" {
  access_key = var.access_key
  secret_key = var.secret_key
  region     = var.region
}