resource "aws_lambda_function" "lambda" {
  function_name = var.function_name
  role          = var.role
  image_uri     = var.image_uri
  memory_size   = var.memory_size
  timeout       = var.timeout

  environment {
    variables = var.environment_variables
  }
}
