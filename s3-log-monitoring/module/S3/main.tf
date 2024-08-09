resource "aws_s3_bucket" "image_bucket" {
  bucket = var.image_bucket_name
}

resource "aws_s3_bucket" "log_bucket" {
  bucket = var.log_bucket_name
}

resource "aws_s3_bucket_logging" "log" {
  bucket        = aws_s3_bucket.image_bucket.id
  target_bucket = aws_s3_bucket.log_bucket.id
  target_prefix = "logs/"
}