resource "aws_api_gateway_rest_api" "AGWtotalView" {
  name        = var.api_gateway_name
  description = "My API Gateway"

  endpoint_configuration {
    types = ["REGIONAL"]
  }

}

resource "aws_api_gateway_resource" "path_totalView" {
  rest_api_id = aws_api_gateway_rest_api.AGWtotalView.id
  parent_id   = aws_api_gateway_rest_api.AGWtotalView.root_resource_id
  path_part   = var.api_gateway_name
}

resource "aws_api_gateway_method" "proxy" {
  rest_api_id      = aws_api_gateway_rest_api.AGWtotalView.id
  resource_id      = aws_api_gateway_resource.path_totalView.id
  http_method      = "ANY"
  authorization    = "NONE"
  api_key_required = false
}

resource "aws_api_gateway_method_response" "proxy_method_resp" {
  rest_api_id = aws_api_gateway_rest_api.AGWtotalView.id
  resource_id = aws_api_gateway_resource.path_totalView.id
  http_method = aws_api_gateway_method.proxy.http_method
  status_code = 200

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers"     = true,
    "method.response.header.Access-Control-Allow-Methods"     = true,
    "method.response.header.Access-Control-Allow-Origin"      = true,
    "method.response.header.Access-Control-Allow-Credentials" = true,
    "method.response.header.Content-Type"                     = true
  }

}

resource "aws_api_gateway_integration_response" "proxy_int_resp" {
  rest_api_id = aws_api_gateway_rest_api.AGWtotalView.id
  resource_id = aws_api_gateway_resource.path_totalView.id
  http_method = aws_api_gateway_method.proxy.http_method
  status_code = aws_api_gateway_method_response.proxy_method_resp.status_code


  //cors
  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers"     = "'*'",
    "method.response.header.Access-Control-Allow-Methods"     = "'*'",
    "method.response.header.Access-Control-Allow-Origin"      = "'${var.api_gateway_allow_access_control_origin}'",
    "method.response.header.Access-Control-Allow-Credentials" = "'true'",
    "method.response.header.Content-Type"                     = "'application/json'"
  }
  response_templates = {
    "application/json" = <<EOF
{
  "statusCode": 200,
  "message": "OK! Everything in order"
}
EOF
  }
  depends_on = [
    aws_api_gateway_method.proxy,
    aws_api_gateway_integration.lambda_integration
  ]
}

resource "aws_api_gateway_integration" "lambda_integration" {
  rest_api_id             = aws_api_gateway_rest_api.AGWtotalView.id
  resource_id             = aws_api_gateway_resource.path_totalView.id
  http_method             = aws_api_gateway_method.proxy.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = var.lambda_function_invoke_arn

  request_templates = {
    "application/json" = "{ 'statusCode': 200 }"
  }
}

resource "aws_api_gateway_gateway_response" "response_4xx" {
  rest_api_id   = aws_api_gateway_rest_api.AGWtotalView.id
  response_type = "DEFAULT_4XX"

  response_templates = {
    "application/json" = "{'message':$context.error.messageString}"
  }

  response_parameters = {
    "gatewayresponse.header.Access-Control-Allow-Origin" = "'${var.api_gateway_allow_access_control_origin}'"
  }
}

resource "aws_api_gateway_gateway_response" "response_5xx" {
  rest_api_id   = aws_api_gateway_rest_api.AGWtotalView.id
  response_type = "DEFAULT_5XX"

  response_templates = {
    "application/json" = "{'message':$context.error.messageString}"
  }

  response_parameters = {
    "gatewayresponse.header.Access-Control-Allow-Origin" = "'${var.api_gateway_allow_access_control_origin}'"
  }
}