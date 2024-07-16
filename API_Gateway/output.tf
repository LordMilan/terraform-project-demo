output "api_gateway_invoke_urls" {
  description = "The URLs of the created API Gateway endpoints"
  value       = aws_apigatewayv2_stage.python_api_stage[*].invoke_url
}