resource "aws_sns_topic" "sns_topic1" {
  name         = var.name
  display_name = var.display_name

  tags = var.tags
}
