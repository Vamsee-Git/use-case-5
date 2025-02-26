resource "aws_lambda_function" "lambda_container" {
  function_name = var.lambda_function_name
  role          = var.iam_role_arn
  package_type  = "Image"
  image_uri     = var.image_uri

  environment {
    variables = {
      ENV = var.environment
    }
  }

  # Enabling X-Ray tracing
  tracing_config {
    mode = "Active"  # This enables X-Ray tracing for the Lambda function
  }
}

# API Gateway to trigger the Lambda function
resource "aws_api_gateway_rest_api" "lambda_container" {
  name        = "${var.lambda_function_name}-api"
  description = "API Gateway to trigger ${var.lambda_function_name}"
}

resource "aws_api_gateway_resource" "lambda_container" {
  rest_api_id = aws_api_gateway_rest_api.lambda_container.id
  parent_id   = aws_api_gateway_rest_api.lambda_container.root_resource_id
  path_part   = "invoke"
}

resource "aws_api_gateway_method" "lambda_container" {
  rest_api_id   = aws_api_gateway_rest_api.lambda_container.id
  resource_id   = aws_api_gateway_resource.lambda_container.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "lambda_container" {
  rest_api_id             = aws_api_gateway_rest_api.lambda_container.id
  resource_id             = aws_api_gateway_resource.lambda_container.id
  http_method             = aws_api_gateway_method.lambda_container.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = "arn:aws:apigateway:${var.region}:lambda:path/2015-03-31/functions/${aws_lambda_function.this.arn}/invocations"
}

# Lambda permissions for API Gateway to invoke the function
resource "aws_lambda_permission" "lambda_container" {
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda_container.function_name
  principal     = "apigateway.amazonaws.com"
}

# Deploy API Gateway to a stage
resource "aws_api_gateway_deployment" "lambda_container" {
  rest_api_id = aws_api_gateway_rest_api.lambda_container.id
  stage_name  = var.api_stage

  depends_on = [
    aws_api_gateway_integration.lambda_container,
    aws_api_gateway_method.lambda_container
  ]
}

output "lambda_invoke_arn" {
  value = aws_lambda_function.lambda_container.invoke_arn
}

output "lambda_function_arn" {
  value = aws_lambda_function.lambda_container.arn
}

output "api_gateway_url" {
  value = "https://${aws_api_gateway_rest_api.lambda_container.id}.execute-api.${var.region}.amazonaws.com/${var.api_stage}/invoke"
}
