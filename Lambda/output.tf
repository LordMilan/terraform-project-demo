output "api_python_lambda_function_invoke_arns" {
  description = "Invoke arn of python Lambda functions that uses api"
  value       = aws_lambda_function.python_lambda_functions[*].invoke_arn
}