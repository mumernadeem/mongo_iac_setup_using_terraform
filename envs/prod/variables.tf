variable "env" {
  type        = string
  default     = "prod"
  description = "Environment name"

  validation {
    condition     = can(regex("^[a-z][a-z0-9-]*$", var.env))
    error_message = "env must be lowercase alphanumeric with hyphens only."
  }
}

variable "aws_region" {
  type        = string
  default     = "us-east-1"
  description = "AWS region"

  validation {
    condition     = can(regex("^[a-z][a-z0-9-]+$", var.aws_region))
    error_message = "aws_region must be a valid AWS region identifier."
  }
}

variable "vpc_cidr" {
  type        = string
  default     = "10.0.0.0/16"
  description = "VPC CIDR"

  validation {
    condition     = can(cidrhost(var.vpc_cidr, 0))
    error_message = "vpc_cidr must be a valid IPv4 CIDR (e.g. 10.0.0.0/16)."
  }
}

variable "azs" {
  type        = list(string)
  description = "Availability zones"
  default     = ["us-east-1a", "us-east-1b", "us-east-1c"]

  validation {
    condition     = length(var.azs) >= 2 && length(var.azs) <= 6
    error_message = "azs must contain between 2 and 6 availability zones."
  }
}

variable "cluster_name" {
  type        = string
  default     = "prod-mongo-eks"
  description = "EKS cluster name"

  validation {
    condition     = length(var.cluster_name) >= 1 && length(var.cluster_name) <= 100 && can(regex("^[a-zA-Z0-9][a-zA-Z0-9-]*$", var.cluster_name))
    error_message = "cluster_name must be 1–100 chars, alphanumeric and hyphens only."
  }
}

variable "cluster_version" {
  type        = string
  default     = "1.28"
  description = "EKS Kubernetes version"

  validation {
    condition     = can(regex("^1\\.(2[89]|[3-9][0-9])$", var.cluster_version))
    error_message = "cluster_version must be a supported EKS version (e.g. 1.28, 1.29)."
  }
}

variable "db_node_instance_type" {
  type        = string
  default     = "m6i.large"
  description = "Instance type for db node group"

  validation {
    condition     = length(var.db_node_instance_type) >= 1
    error_message = "db_node_instance_type cannot be empty."
  }
}

variable "app_node_instance_type" {
  type        = string
  default     = "m6i.large"
  description = "Instance type for app node group"

  validation {
    condition     = length(var.app_node_instance_type) >= 1
    error_message = "app_node_instance_type cannot be empty."
  }
}
