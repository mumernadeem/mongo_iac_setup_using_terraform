variables {
  env          = "prod"
  vpc_cidr     = "10.0.0.0/16"
  cluster_name = "prod-mongo-eks"
  cluster_version = "1.28"
  azs = ["us-east-1a", "us-east-1b", "us-east-1c"]
  db_node_instance_type  = "m6i.large"
  app_node_instance_type = "m6i.large"
}

# Validate composition and key outputs (run uses default behavior)
run "prod_composition_plan" {
  assert {
    condition     = length(module.network.private_subnet_ids) >= 1
    error_message = "Network module must expose private_subnet_ids for EKS."
  }

  assert {
    condition     = module.network.vpc_id != ""
    error_message = "Network module must output vpc_id."
  }

  assert {
    condition     = module.eks.cluster_name == var.cluster_name
    error_message = "EKS cluster_name output must match variable."
  }

  assert {
    condition     = module.eks.cluster_endpoint != ""
    error_message = "EKS module must output cluster_endpoint."
  }

  assert {
    condition     = module.backups.backup_bucket_name != ""
    error_message = "Backups module must output backup_bucket_name for PBM/IAM."
  }

  assert {
    condition     = can(module.storage.db_storage_class)
    error_message = "Storage module must output db_storage_class for MongoDB."
  }

  assert {
    condition     = can(module.iam.pbm_irsa_role_arn)
    error_message = "IAM module must output pbm_irsa_role_arn for PBM S3 access."
  }
}
