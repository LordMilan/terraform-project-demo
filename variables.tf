variable "base_name" {
  description = "AWS region"
  type        = string
}

variable "aws_region" {
  description = "aws region"
  type        = string
  #default     = "ap-south-1" # Default region

}

variable "aws_access_key" {
  description = "access key of aws account"
  type        = string
}

variable "aws_secret_key" {
  description = "secret key of aws"
  type        = string
}

################### variables required for lambda ############################################################################################
variable "python_function_names" {
  description = "List of lambda function names that uses sqs "
  type        = list(string)
}
