resource "aws_lambda_function" "keysersoze_lambda_totalViewer" {
  filename         = data.archive_file.zip_the_python_code.output_path
  source_code_hash = data.archive_file.zip_the_python_code.output_base64sha256
  function_name    = var.lambda_function_name
  role             = var.iam_role_arn
  handler          = "${var.lambda_function_name}.lambda_handler"
  runtime          = "python3.12"
}

data "archive_file" "zip_the_python_code" {
  type        = "zip"
  source_file = "${path.root}/${var.lambda_function_name}.py"
  output_path = "${path.root}/${var.lambda_function_name}.zip"
}

resource "aws_lambda_function_url" "keysersoze_lambda_totalViewer_url" {
  function_name      = aws_lambda_function.keysersoze_lambda_totalViewer.function_name
  authorization_type = "NONE"

  cors {
    allow_credentials = true
    allow_origins     = ["*"]
    allow_methods     = [var.api_gateway_allow_access_control_origin]
    allow_headers     = ["date", "keep-alive"]
    expose_headers    = ["keep-alive", "date"]
    max_age           = 86400
  }
}