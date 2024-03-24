terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  alias      = "acm"
  region     = var.acm_region
  access_key = var.acm_access_key
  secret_key = var.acm_secret_key
}

resource "aws_acm_certificate" "keysersoze_cert" {
  provider          = aws.acm
  domain_name       = var.acm_domain_name
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}
