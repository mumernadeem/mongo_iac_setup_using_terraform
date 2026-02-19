variable "cluster_name" {
  type        = string
  description = "EKS cluster name"
}

variable "cluster_version" {
  type        = string
  description = "Kubernetes version for EKS"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID from network module"
}

variable "private_subnet_ids" {
  type        = list(string)
  description = "Private subnet IDs for EKS"
}

variable "db_node_instance_type" {
  type        = string
  description = "Instance type for db node group (e.g. m6i.large)"
}

variable "app_node_instance_type" {
  type        = string
  description = "Instance type for app node group"
}
