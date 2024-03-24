variable "access_key" {
  type      = string
  default   = ""
  sensitive = true
}

variable "secret_key" {
  type      = string
  default   = ""
  sensitive = true
}

variable "region" {
  type      = string
  default   = ""
  sensitive = true
}

variable "region_acm" {
  type      = string
  default   = ""
  sensitive = true
}


variable "zone_id" {
  type      = string
  default   = ""
  sensitive = true
}

variable "account_id" {
  type      = string
  default   = ""
  sensitive = true
}

variable "domain" {
  type      = string
  default   = ""
  sensitive = true
}

variable "domain_firstname" {
  type      = string
  default   = ""
  sensitive = true
}

variable "cloudflare_token" {
  type      = string
  default   = ""
  sensitive = true
}

variable "tags" {
  type      = string
  default   = ""
  sensitive = true
}

variable "s3_bucket_name" {
  type      = string
  default   = ""
  sensitive = true
}
variable "lambda_function_name" {
  type      = string
  default   = ""
  sensitive = false
}

variable "api_gateway_stage_name" {
  type      = string
  default   = ""
  sensitive = false
}

variable "s3_folder_location_upload" {
  type      = string
  default   = ""
  sensitive = false
}