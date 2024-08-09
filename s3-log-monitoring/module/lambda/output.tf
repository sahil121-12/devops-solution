# modules/lambda/outputs.tf

output "lambda_function_arn" {
  description = "The ARN of the Lambda function."
  value       = aws_lambda_function.lambda_function_service.arn
}
