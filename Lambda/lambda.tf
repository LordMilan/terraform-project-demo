# Zipped code of lambda #
data "archive_file" "python_lambda_zip" {
  type        = "zip"
  source_file = "${path.module}/code/lambda_function.py"
  output_path = "python_lambda_function_payload.zip"
}

# Lambda Function #
resource "aws_lambda_function" "python_lambda_functions" {
  count         = length(var.python_function_names)
  function_name = var.python_function_names[count.index]
  filename      = "python_lambda_function_payload.zip"
  source_code_hash = data.archive_file.python_lambda_zip.output_base64sha256
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.9"
  timeout      = 900 # seconds
  role         = aws_iam_role.lambda_access_role.arn
  memory_size  = "128"
  depends_on = [aws_cloudwatch_log_group.python_lambda_logs]
}

# Cloudwatch Log Group for lambda #
resource "aws_cloudwatch_log_group" "python_lambda_logs" {
  count             = length(var.python_function_names)
  name              = "/aws/lambda/${var.python_function_names[count.index]}"
  retention_in_days = 7
}