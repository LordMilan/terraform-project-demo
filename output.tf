
locals {
  function_invoke_urls = [
    for idx in range(length(var.python_function_names)) :
    "${module.api_gateway.api_gateway_invoke_urls[idx]}/${var.python_function_names[idx]}"
  ]
}

output "api_gateway_invoke_urls" {
  description = "The URLs of the created API Gateway endpoints with function names"
  value       = local.function_invoke_urls
}
