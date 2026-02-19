variable "vpc_cidr" {
  description = "CIDR for the VPC (e.g. 10.0.0.0/16)"
  type        = string
}

variable "azs" {
  description = "List of availability zones"
  type        = list(string)
}

variable "env" {
  description = "Environment name for naming and tags"
  type        = string
}
