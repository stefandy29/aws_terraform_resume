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

resource "cloudflare_record" "cloudfront_hidden_url" {
  zone_id = var.zone_id
  name    = var.domain_hidden_name
  value   = var.domain_hidden_value
  type    = "CNAME"
  proxied = false
}