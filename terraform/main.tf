module "vpc" {
  source              = "./modules/vpc"
  vpc_cidr_block      = var.vpc_cidr_block
  public_subnet_cidr  = var.public_subnet_cidr
  private_subnet_cidr = var.private_subnet_cidr
  availability_zone    = var.availability_zone
}

module "iam" {
  source          = "./modules/iam"
  lambda_role_name = var.lambda_role_name
}

module "ecr" {
  source         = "./modules/ecr"
  repository_name = var.repository_name
}

module "lambda" {
  source            = "./modules/lambda"

  function_name = var.function_name
  role          = module.iam.lambda_role_arn  # or a reference to your IAM role ARN
  image_uri     = var.image_uri
  memory_size   = var.memory_size
  timeout       = var.timeout

  environment_variables = {
    MY_ENV_VAR = "value"
  }

  # Additional options as needed
}

module "api_gateway" {
  source = "./modules/api_gateway"   # Or your own module source

  # Define API Gateway specifics as supported by the module
  name        = var.api_name
  description = "API Gateway for Lambda integration"

  # Define the method and integration with Lambda function
  resource = {
    path_part = "my-resource"
    method    = "GET"
    integration = {
      type                   = "AWS_PROXY"
      integration_http_method = "POST"
      uri                    = module.lambda.lambda_function.invoke_arn
    }
  }

  stage_name = var.stage_name
}
