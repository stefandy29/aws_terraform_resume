variable "s3_bucket_name" {
  description = "s3 bucket name"
  type        = string
  default     = ""
}

variable "s3_folder_location_upload" {
  description = "s3 folder location upload"
  type        = string
  default     = ""
}

variable "s3_bucket_arn" {
  description = "s3 folder location upload"
  type        = string
  default     = ""
}

variable "s3_block_public_acls" {
  description = "s3_block_public_acls"
  type        = bool
  default     = true
}

variable "s3_block_public_policy" {
  description = "s3_block_public_policy"
  type        = bool
  default     = true
}

variable "s3_ignore_public_acls" {
  description = "s3_ignore_public_acls"
  type        = bool
  default     = true
}

variable "s3_restrict_public_buckets" {
  description = "s3_restrict_public_buckets"
  type        = bool
  default     = true
}

variable "s3_bucket_website_configuration_suffix" {
  default = "index.html"
}

variable "s3_tags" {
  type = string
}

variable "lambda_function_name" {
  
}