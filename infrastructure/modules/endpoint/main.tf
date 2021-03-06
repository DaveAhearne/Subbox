data "archive_file" "zip_lambda" {
  type        = "zip"
  source_dir  = "../api/lambdas/${var.lambda_name}"
  output_path = "../api/build/${var.lambda_name}.zip"
}

resource "aws_api_gateway_method" "gateway_http_method" {
  rest_api_id   = var.api_gateway_id
  resource_id   = var.api_gateway_resource_id
  http_method   = var.http_method
  authorization = "NONE"
}

resource "aws_iam_role" "iam_for_lambda" {
  name = "iam_for_lambda_${var.lambda_name}"

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

resource "aws_iam_role_policy" "dynamodb-lambda-policy"{
  name = "dynamodb_lambda_policy_${var.lambda_name}"
  role = aws_iam_role.iam_for_lambda.id
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "dynamodb:*"
      ],
      "Resource": "${var.environment_variables.table_arn}"
    }
  ]
}
EOF
}

# Attaches the role that allows lambdas to write to cloudwatch etc
resource "aws_iam_role_policy_attachment" "basic-exec-role" {
    role       = aws_iam_role.iam_for_lambda.name
    policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_lambda_permission" "api_gateway_execute_permissions" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda.function_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "arn:aws:execute-api:${var.region}:${var.account_id}:${var.api_gateway_id}/*"
}

resource "aws_lambda_function" "lambda" {
  filename      = "../api/build/${var.lambda_name}.zip"
  source_code_hash = data.archive_file.zip_lambda.output_sha

  function_name = var.lambda_name
  role          = aws_iam_role.iam_for_lambda.arn
  handler       = "index.handler"
  runtime       = "nodejs12.x"

  environment {
    variables = var.environment_variables
  }
}

resource "aws_api_gateway_integration" "lambda_integration" {
  rest_api_id = var.api_gateway_id
  resource_id = var.api_gateway_resource_id
  http_method = aws_api_gateway_method.gateway_http_method.http_method

  depends_on = [
    aws_api_gateway_method.gateway_http_method
  ]
  
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.lambda.invoke_arn
}