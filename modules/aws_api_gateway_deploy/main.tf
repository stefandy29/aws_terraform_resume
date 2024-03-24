resource "aws_api_gateway_deployment" "agw_deploy" {
  rest_api_id       = var.api_gateway_rest_api_id
  stage_description = timestamp()
  description       = "Deployed at ${timestamp()}"
  triggers = {
    redeployment = sha1(jsonencode(var.api_gateway_rest_api_body))
  }
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_stage" "agw_views" {
  deployment_id = aws_api_gateway_deployment.agw_deploy.id
  rest_api_id   = var.api_gateway_rest_api_id
  stage_name    = var.api_gateway_stage_name
}