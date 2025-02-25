# VPC Configuration
variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "public_subnet_cidr" {
  description = "CIDR block for the public subnet"
  type        = string
}

variable "private_subnet_cidr" {
  description = "CIDR block for the private subnet"
  type        = string
}

variable "availability_zone" {
  description = "Availability zone for subnets"
  type        = string
}

# Lambda IAM Role
variable "lambda_role_name" {
  description = "Name for the Lambda IAM role"
  type        = string
}

# ECR Repository
variable "repository_name" {
  description = "ECR repository name"
  type        = string
}

# Lambda Configuration
variable "function_name" {
  description = "Lambda function name"
  type        = string
}

variable "lambda_role_arn" {
  description = "IAM role ARN for Lambda execution"
  type        = string
}

variable "image_uri" {
  description = "URI of the container image in ECR"
  type        = string
}

variable "memory_size" {
  description = "Memory size for the Lambda function"
  type        = number
}

variable "timeout" {
  description = "Timeout for the Lambda function"
  type        = number
}

# API Gateway Configuration
variable "stage_name" {
  description = "Deployment stage for API Gateway"
  type        = string
}

variable "api_name" {
  description = "API Gateway name"
  type        = string
}

variable "lambda_function_uri" {
  description = "Lambda function URI for API Gateway integration"
  type        = string
}
