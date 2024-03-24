output "lambda_function_name" {
  value = aws_lambda_function.keysersoze_lambda_totalViewer.function_name
}

output "lambda_function_invoke_arn" {
  value = aws_lambda_function.keysersoze_lambda_totalViewer.invoke_arn
}