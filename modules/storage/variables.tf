variable "kms_key_id" {
  type        = string
  default     = null
  description = "KMS key for EBS encryption"
}

variable "db_iops" {
  type        = number
  default     = 3000
  description = "GP3 IOPS for MongoDB volumes"
}

variable "db_throughput" {
  type        = number
  default     = 125
  description = "GP3 throughput (MiB/s) for MongoDB volumes"
}
