variable "env" {
  description = "Environment for bucket naming (e.g. prod-mongo-backups)"
  type        = string
}

variable "kms_key_id" {
  description = "KMS key ARN for bucket encryption; null for default SSE"
  type        = string
  default     = null
}
