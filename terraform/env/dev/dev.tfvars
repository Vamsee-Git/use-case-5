# VPC Setup
vpc_cidr_block      = "10.1.0.0/16"
public_subnet_cidr  = "10.1.1.0/24"
private_subnet_cidr = "10.1.2.0/24"
availability_zone    = "ap-south-1a"

# Lambda IAM Role
lambda_role_name = "lambda-role"

# ECR Setup
repository_name = "my-lambda-container-repo"

# Lambda Function Setup
function_name   = "my-lambda-function"
lambda_role_arn = "arn:aws:iam::314146309097:role/lambda-role" # Adjust as per your setup
image_uri       = "314146309097.dkr.ecr.ap-south-1.amazonaws.com/my-lambda-container-repo:latest"

# Lambda Configuration
memory_size     = 256
timeout         = 30

# API Gateway
stage_name      = "prod"
api_name        = "lambda-api"
lambda_function_uri = "arn:aws:lambda:ap-south-1:314146309097:function:my-lambda-function" # Example ARN, update as necessary
