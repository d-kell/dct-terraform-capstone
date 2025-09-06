output "bucket_arn" {
  description = "The ARN of the S3 bucket"
  value       = aws_s3_bucket.bucket.arn
}

output "bucket_id"   { value = aws_s3_bucket.bucket.id }

output "bucket_name" { value = aws_s3_bucket.bucket.bucket }