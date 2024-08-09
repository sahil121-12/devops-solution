variable "function_name" {
  description = "The name of the Lambda function."
  type        = string
}

variable "handler" {
  description = "The function entry point in your code."
  type        = string
}

variable "runtime" {
  description = "The runtime environment for the Lambda function."
  type        = string
}

variable "timeout" {
  description = "The amount of time that Lambda allows a function to run before stopping it."
  type        = number
  default     = 120
}

variable "memory_size" {
  description = "The amount of memory available to the function at runtime."
  type        = number
  default     = 256
}

variable "description" {
  description = "The description of the Lambda function."
  type        = string
}

variable "environment_variables" {
  description = "Environment variables for the Lambda function."
  type        = map(string)
  default     = {}
}

variable "tags" {
  description = "Tags for the resources."
  type        = map(string)
  default     = {}
}

variable "log_retention_in_days" {
  description = "The number of days log events are kept in CloudWatch Logs."
  type        = number
  default     = 7
}

variable "maximum_event_age_in_seconds" {
  description = "The maximum age of a request that Lambda sends to a function for processing."
  type        = number
  default     = 3600
}

variable "maximum_retry_attempts" {
  description = "The maximum number of times to retry when the function returns an error."
  type        = number
  default     = 0
}

variable "event_rule_description" {
  description = "Description for the CloudWatch event rule."
  type        = string
  default     = "CloudWatch event rule for Lambda function."
}

variable "schedule_expression" {
  description = "The scheduling expression that determines when and how often the rule runs."
  type        = string
  default     = "cron(0 0 * * ? *)"
}

variable "source_account" {
  description = "The AWS account ID (without dashes)."
  type        = string
}

variable "event_source_arn" {
  description = "The ARN of the event source."
  type        = string
}

variable "event_source_enabled" {
  description = "Specifies whether the event source mapping is enabled."
  type        = bool
  default     = true
}

variable "batch_size" {
  description = "The largest number of records that Lambda retrieves from your event source at the time of invocation."
  type        = number
  default     = 1
}

variable "sns_topic_name" {
  description = "The name of the SNS topic."
  type        = string
}

variable "sns_topic_arn" {
  description = "The ARN of the SNS topic to which the Lambda function can publish messages."
  type        = string
}

variable "aws_region" {
  description = "The AWS region where resources will be created."
  type        = string
}