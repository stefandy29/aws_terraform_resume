terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4"
    }
  }
}
provider "cloudflare" {
  api_token = var.cloudflare_token
}

resource "cloudflare_record" "cloudfront_real_url" {
  zone_id = var.zone_id
  name    = var.domain_name
  value   = var.cloudfront_distrib_domain_name
  type    = "CNAME"
  proxied = true
}
