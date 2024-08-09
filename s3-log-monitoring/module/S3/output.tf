output "image_bucket_id" {
  value = aws_s3_bucket.image_bucket.id
}

output "log_bucket_id" {
  value = aws_s3_bucket.log_bucket.id
}
