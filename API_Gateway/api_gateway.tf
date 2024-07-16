resource "aws_apigatewayv2_api" "python_api" {
  count         = length(var.python_function_names)
  name          = "${var.python_function_names[count.index]}-API"
  protocol_type = "HTTP"
}

resource "aws_apigatewayv2_stage" "python_api_stage" {
  count       = length(var.python_function_names)
  api_id      = aws_apigatewayv2_api.python_api[count.index].id
  name        = var.base_name
  auto_deploy = true
}

resource "aws_lambda_permission" "python_apigw" {
  count         = length(var.python_function_names)
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = var.python_function_names[count.index]
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_apigatewayv2_api.python_api[count.index].execution_arn}/*"
  depends_on = [ aws_apigatewayv2_api.python_api ]
}

resource "aws_apigatewayv2_integration" "python_lambda_integration" {
  count                = length(var.python_function_names)
  api_id               = aws_apigatewayv2_api.python_api[count.index].id
  integration_type     = "AWS_PROXY"
  integration_uri      = var.python_lambda_function_invoke_arns[count.index]
  connection_type      = "INTERNET"
  timeout_milliseconds = 29000
}

resource "aws_apigatewayv2_route" "python_lambda_route" {
  count     = length(var.python_function_names)
  api_id    = aws_apigatewayv2_api.python_api[count.index].id
  route_key = "ANY /${var.python_function_names[count.index]}"
  target    = "integrations/${aws_apigatewayv2_integration.python_lambda_integration[count.index].id}"
}