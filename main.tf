terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region     = var.aws_region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

module "lambda_functions" {
  source                = "./Lambda"
  aws_region            = var.aws_region
  python_function_names = var.python_function_names
  base_name             = var.base_name
}

module "api_gateway" {
  source                                 = "./API_Gateway"
  python_lambda_function_invoke_arns = module.lambda_functions.api_python_lambda_function_invoke_arns
  python_function_names = var.python_function_names
  base_name                              = var.base_name
  depends_on = [ module.lambda_functions ]
}
