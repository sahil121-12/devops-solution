# modules/sns/variables.tf

variable "name" {
  description = "The name of the SNS topic."
  type        = string
}

variable "display_name" {
  description = "The display name of the SNS topic."
  type        = string
}

variable "tags" {
  description = "Tags for the SNS topic."
  type        = map(string)
  default     = {}
}
