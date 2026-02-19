output "vpc_id" {
  value = module.network.vpc_id
}

output "private_subnet_ids" {
  value = module.network.private_subnet_ids
}

output "cluster_name" {
  value = module.eks.cluster_name
}

output "cluster_endpoint" {
  value = module.eks.cluster_endpoint
}

output "backup_bucket_name" {
  value = module.backups.backup_bucket_name
}

output "pbm_irsa_role_arn" {
  value = module.iam.pbm_irsa_role_arn
}

output "db_storage_class" {
  value = module.storage.db_storage_class
}
