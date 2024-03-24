output "api_gateway_execution_arn" {
  value = aws_api_gateway_rest_api.AGWtotalView.execution_arn
}

output "api_gateway_rest_api_id" {
  value = aws_api_gateway_rest_api.AGWtotalView.id
}

output "api_gateway_rest_api_body" {
  value = aws_api_gateway_rest_api.AGWtotalView.body
}