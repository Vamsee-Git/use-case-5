output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnet_id" {
  value = module.vpc.public_subnet_id
}

output "lambda_function_name" {
  value = module.lambda.function_name
}

output "api_gateway_url" {
  value = "https://${module.api_gateway.api_gateway_url}/${module.api_gateway.stage_name}"
}
