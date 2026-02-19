# EKS module tests - cluster, db and app node groups, IRSA 

variables {
  cluster_name         = "prod-mongo-eks"
  cluster_version      = "1.28"
  vpc_id               = "vpc-placeholder"
  private_subnet_ids   = ["subnet-1", "subnet-2", "subnet-3"]
  db_node_instance_type  = "m6i.large"
  app_node_instance_type = "m6i.large"
}

run "eks_cluster_created" {
  assert {
    condition     = aws_eks_cluster.main.name == var.cluster_name
    error_message = "EKS cluster name must match variable."
  }

  assert {
    condition     = aws_eks_cluster.main.version == var.cluster_version
    error_message = "EKS cluster version must match variable."
  }
}

run "db_node_group_taints" {
  assert {
    condition     = length(aws_eks_node_group.db.taint) >= 1
    error_message = "DB node group must have taint role=db:NoSchedule to isolate MongoDB."
  }
}

run "eks_outputs_for_providers" {
  assert {
    condition     = aws_eks_cluster.main.endpoint != ""
    error_message = "cluster_endpoint required for kubernetes/helm providers."
  }

  assert {
    condition     = aws_eks_cluster.main.certificate_authority[0].data != ""
    error_message = "cluster_ca_certificate required for kubernetes provider."
  }

  assert {
    condition     = aws_iam_openid_connect_provider.eks.arn != ""
    error_message = "OIDC provider required for IRSA (PBM, Prometheus)."
  }
}
