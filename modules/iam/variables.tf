variable "cluster_oidc_provider_arn" {
  type        = string
  description = "EKS OIDC provider ARN"
}

variable "oidc_provider_url" {
  type        = string
  description = "EKS OIDC issuer URL (without https://)"
}

variable "backup_bucket_name" {
  type        = string
  description = "S3 backup bucket name for PBM"
}
