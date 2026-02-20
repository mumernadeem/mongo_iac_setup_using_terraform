# Order is implied by dependencies; Terraform resolves automatically.

module "network" {
  source   = "../../modules/network"
  vpc_cidr = var.vpc_cidr
  azs      = var.azs
  env      = var.env
}

module "eks" {
  source                  = "../../modules/eks"
  cluster_name            = var.cluster_name
  cluster_version         = var.cluster_version
  vpc_id                  = module.network.vpc_id
  private_subnet_ids      = module.network.private_subnet_ids
  db_node_instance_type   = var.db_node_instance_type
  app_node_instance_type  = var.app_node_instance_type
}

module "backups" {
  source     = "../../modules/backups"
  env        = var.env
  kms_key_id = null
}

module "iam" {
  source                    = "../../modules/iam"
  cluster_oidc_provider_arn = module.eks.oidc_provider_arn
  oidc_provider_url         = module.eks.oidc_issuer_url
  backup_bucket_name        = module.backups.backup_bucket_name
}

module "storage" {
  source     = "../../modules/storage"
  kms_key_id = null
  db_iops    = 3000
  db_throughput = 125
}


