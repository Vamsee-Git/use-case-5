# modules/iam/main.tf

variable "lambda_role_name" {
  description = "Name of the IAM role for Lambda function"
  type        = string
}

resource "aws_iam_role" "lambda_role" {
  name               = var.lambda_role_name
  assume_role_policy = data.aws_iam_policy_document.lambda_assume_role_policy.json
}

# Attach policies to the role (if needed)
resource "aws_iam_role" "lambda_role" {
  name = "lambda_role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_policy" "lambda_policy" {
  name        = "LambdaPolicy"
  description = "Policy to allow Lambda to execute and retrieve container images from ECR"
  policy      = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "LambdaBasicExecutionRole",
      "Effect": "Allow",
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
             "Resource": "*"
    },
    {
      "Sid": "LambdaECRImageRetrievalPolicy",
      "Effect": "Allow",
      "Action": [
        "ecr:BatchGetImage",
        "ecr:GetDownloadUrlForLayer"
      ],
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "lambda_policy_attachment" {
  policy_arn = aws_iam_policy.lambda_policy.arn
  role       = aws_iam_role.lambda_role.name
}
