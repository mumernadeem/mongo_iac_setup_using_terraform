# Production: use S3 + DynamoDB. Configure via -backend-config or env.

terraform {
  required_version = ">= 1.6.0"

  backend "s3" {
    region = "us-east-1"
    # bucket, key, dynamodb_table via -backend-config
  }
}
