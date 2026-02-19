output "backup_bucket_name" {
  description = "S3 bucket name for MongoDB backups (PBM)"
  value       = aws_s3_bucket.backup.id
}
