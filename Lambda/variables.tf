variable "base_name" {
  description = "AWS region"
  type        = string
}

variable "aws_region" {
  description = "aws region"
  type        = string
  #default     = "ap-south-1" # Default region

}

################### variables required for lambda ############################################################################################
variable "python_function_names" {
  description = "List of lambda function names that uses sqs "
  type        = list(string)
}
