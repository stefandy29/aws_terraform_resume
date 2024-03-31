module "aws_dynamodb" {
  source            = "./modules/aws_dynamodb"
  dynamodb_name     = "dynamodb-${var.tags}"
  dynamodb_hashkey  = "id"
  dynamodb_item_key = var.api_gateway_stage_name
  dynamodb_tags     = var.tags
}

module "local_file_python" {
  source               = "./modules/local_file_python"
  lambda_function_name = var.lambda_function_name
  dynamodb_name        = "dynamodb-${var.tags}"
  dynamodb_hashkey     = "id"
  dynamodb_item_key    = var.api_gateway_stage_name
  api_gateway_allow_access_control_origin = replace(var.domain, "*", var.domain_firstname)
}

module "aws_iam" {
  source        = "./modules/aws_iam"
  lambda_name   = var.lambda_function_name
  dynamodb_name = "dynamodb-${var.tags}"
}

module "aws_lambda" {
  source               = "./modules/aws_lambda"
  lambda_function_name = var.lambda_function_name
  iam_role_arn         = module.aws_iam.iam_role_arn
  api_gateway_allow_access_control_origin = replace(var.domain, "*", var.domain_firstname)
}

module "aws_api_gateway" {
  source                                  = "./modules/aws_api_gateway"
  api_gateway_name                        = var.lambda_function_name
  lambda_function_invoke_arn              = module.aws_lambda.lambda_function_invoke_arn
  api_gateway_allow_access_control_origin = replace(var.domain, "*", var.domain_firstname)
}

module "aws_lambda_api_gateway_permission" {
  source                    = "./modules/aws_lambda_api_gateway_permission"
  lambda_function_name      = module.aws_lambda.lambda_function_name
  api_gateway_execution_arn = module.aws_api_gateway.api_gateway_execution_arn
}

module "aws_api_gateway_deploy" {
  source                    = "./modules/aws_api_gateway_deploy"
  api_gateway_stage_name    = var.api_gateway_stage_name
  api_gateway_rest_api_id   = module.aws_api_gateway.api_gateway_rest_api_id
  api_gateway_rest_api_body = module.aws_api_gateway.api_gateway_rest_api_body
}

module "local_file_javascript" {
  source                    = "./modules/local_file_javascript"
  s3_folder_location_upload = var.s3_folder_location_upload
  api_gateway_url           = "${module.aws_api_gateway_deploy.api_gateway_deploy_invoke_url}${var.api_gateway_stage_name}/${var.lambda_function_name}"
}

module "aws_s3_bucket" {
  source                    = "./modules/aws_s3_bucket"
  s3_bucket_name            = "s3-${var.tags}"
  s3_tags                   = var.tags
  s3_folder_location_upload = var.s3_folder_location_upload
  lambda_function_name      = var.lambda_function_name
}

module "aws_acm" {
  source          = "./modules/aws_acm"
  acm_domain_name = var.domain
  acm_access_key  = var.access_key
  acm_secret_key  = var.secret_key
  acm_region      = var.region_acm
}

module "cloudflare_record_hidden" {
  source              = "./modules/cloudflare_record_hidden"
  zone_id             = var.zone_id
  domain_hidden_name  = module.aws_acm.acm_domain_validation_option_name
  domain_hidden_value = module.aws_acm.acm_domain_validation_option_value
  cloudflare_token    = var.cloudflare_token
}

module "aws_cloudfront" {
  source                      = "./modules/aws_cloudfront"
  bucket_name                 = module.aws_s3_bucket.s3_bucket_name
  bucket_regional_domain_name = module.aws_s3_bucket.s3_bucket_regional_domain_name
  acm_certificate_arn         = module.aws_acm.acm_certificate_arn
  cloudfront_alias            = replace(var.domain, "*", var.domain_firstname)
  cloudfront_origin_id        = "cloudfront-origin-${var.tags}"
}

module "cloudflare_record_real" {
  source                         = "./modules/cloudflare_record_real"
  zone_id                        = var.zone_id
  cloudflare_token               = var.cloudflare_token
  domain_name                    = replace(var.domain, "*.", "")
  cloudfront_distrib_domain_name = module.aws_cloudfront.cloudfront_distrub_domain_name
}

module "aws_s3_policy" {
  source                 = "./modules/aws_s3_policy"
  s3_bucket_id           = module.aws_s3_bucket.s3_bucket_id
  s3_bucket_arn          = module.aws_s3_bucket.s3_bucket_arn
  cloudfront_distrib_arn = module.aws_cloudfront.cloudfront_distrub_arn
}