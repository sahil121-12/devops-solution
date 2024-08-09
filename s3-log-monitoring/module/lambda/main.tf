provider "aws" {
  region = var.aws_region
}

data "archive_file" "archive_function_obj" {
  type        = "zip"
  source_dir  = "${path.module}/function"
  output_path = "${path.module}/lambda_function.zip"
}

resource "aws_iam_role" "lambda_execution_role" {
  name = "${var.function_name}_execution_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = var.tags
}

resource "aws_iam_policy" "lambda_policy" {
  name = "${var.function_name}_policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Resource = "arn:aws:logs:*:*:*"
      },
      {
        Effect = "Allow"
        Action = [
          "sqs:ReceiveMessage",
          "sqs:DeleteMessage",
          "sqs:GetQueueAttributes"
        ]
        Resource = var.event_source_arn
      }
    ]
  })

  tags = var.tags
}

resource "aws_iam_role_policy_attachment" "lambda_execution_role_attachment" {
  role       = aws_iam_role.lambda_execution_role.name
  policy_arn = aws_iam_policy.lambda_policy.arn
}

resource "aws_lambda_function" "lambda_function_service" {
  filename         = data.archive_file.archive_function_obj.output_path
  source_code_hash = filebase64sha256(data.archive_file.archive_function_obj.output_path)
  function_name    = var.function_name
  role             = aws_iam_role.lambda_execution_role.arn
  handler          = var.handler
  runtime          = var.runtime
  timeout          = var.timeout
  memory_size      = var.memory_size
  description      = var.description

  environment {
    variables = var.environment_variables
  }

  tags = var.tags
}

resource "aws_cloudwatch_log_group" "global_cloudwatch_log_group" {
  name              = "/aws/lambda/${aws_lambda_function.lambda_function_service.function_name}"
  retention_in_days = var.log_retention_in_days

  tags = var.tags
}

resource "aws_lambda_function_event_invoke_config" "event_invoke_config" {
  function_name                = aws_lambda_function.lambda_function_service.function_name
  maximum_event_age_in_seconds = var.maximum_event_age_in_seconds
  maximum_retry_attempts       = var.maximum_retry_attempts
}

resource "aws_lambda_permission" "lambda_permission_sqs" {
  statement_id  = "AllowExecutionFromSQS"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda_function_service.function_name
  principal     = "sqs.amazonaws.com"
  source_arn    = var.event_source_arn
  source_account = var.source_account
}

resource "aws_lambda_event_source_mapping" "event_source_mapping" {
  event_source_arn = var.event_source_arn
  enabled          = var.event_source_enabled
  function_name    = aws_lambda_function.lambda_function_service.function_name
  batch_size       = var.batch_size
}