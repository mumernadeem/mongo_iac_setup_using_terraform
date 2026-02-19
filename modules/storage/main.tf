# StorageClass for MongoDB - EBS CSI gp3 encrypted
# Requires EKS cluster and kubernetes provider to be configured by caller
resource "kubernetes_storage_class" "mongo_gp3" {
  count = var.kms_key_id != null ? 1 : 0

  metadata {
    name = "mongo-gp3-encrypted"
  }
  storage_provisioner    = "ebs.csi.aws.com"
  allow_volume_expansion = true
  reclaim_policy         = "Retain"
  volume_binding_mode   = "WaitForFirstConsumer"
  parameters = {
    type      = "gp3"
    encrypted = "true"
    kmsKeyId  = var.kms_key_id
    iops      = tostring(var.db_iops)
    throughput = tostring(var.db_throughput)
  }
}

# Default encrypted gp3 when no KMS key (uses default EBS key)
resource "kubernetes_storage_class" "mongo_gp3_default" {
  count = var.kms_key_id == null ? 1 : 0

  metadata {
    name = "mongo-gp3-encrypted"
  }
  storage_provisioner    = "ebs.csi.aws.com"
  allow_volume_expansion = true
  reclaim_policy         = "Retain"
  volume_binding_mode   = "WaitForFirstConsumer"
  parameters = {
    type      = "gp3"
    encrypted = "true"
    iops      = tostring(var.db_iops)
    throughput = tostring(var.db_throughput)
  }
}
