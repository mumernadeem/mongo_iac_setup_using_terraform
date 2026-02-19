# Backups module - S3 bucket for MongoDB backups

variables {
  env        = "prod"
  kms_key_id = null
}

run "backup_bucket_created" {
  assert {
    condition     = startswith(aws_s3_bucket.backup.id, var.env)
    error_message = "Bucket name should be prefixed with env (e.g. prod-mongo-backups)."
  }

  assert {
    condition     = aws_s3_bucket_versioning.backup.versioning_configuration[0].status == "Enabled"
    error_message = "Versioning must be enabled for backup bucket."
  }
}

run "backup_bucket_output" {
  assert {
    condition     = backup_bucket_name != ""
    error_message = "backup_bucket_name output must be set for IAM and MongoDB modules."
  }
}
