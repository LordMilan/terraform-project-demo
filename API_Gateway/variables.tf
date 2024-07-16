variable "base_name" {
  description = "AWS region"
  type        = string
}

################### variables required for lambda ############################################################################################
variable "python_function_names" {
  description = "List of lambda function names that uses sqs "
  type        = list(string)
}

variable "python_lambda_function_invoke_arns" {
  description = "List of Lambda function ARNs to integrate with API Gateway"
  type        = list(string)
  default     = [] # Default to an empty list
}