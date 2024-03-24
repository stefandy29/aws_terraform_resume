variable "acm_domain_name" {
  type      = string
  default   = ""
  sensitive = true
}

variable "acm_certificate_arn" {
  type      = string
  default   = ""
  sensitive = true
}

variable "acm_access_key" {
  type      = string
  default   = ""
  sensitive = true
}

variable "acm_secret_key" {
  type      = string
  default   = ""
  sensitive = true
}

variable "acm_region" {
  type      = string
  default   = ""
  sensitive = true
}