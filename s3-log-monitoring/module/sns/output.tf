# modules/sns/outputs.tf

output "sns_topic_arn" {
  description = "The ARN of the SNS topic."
  value       = aws_sns_topic.sns_topic1.arn
}

# modules/sns/outputs.tf
output "sns_topic_name" {
  value = aws_sns_topic.sns_topic1.name
}
