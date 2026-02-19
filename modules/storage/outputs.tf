output "db_storage_class" {
  description = "StorageClass name for MongoDB (mongo-gp3-encrypted)"
  value       = try(kubernetes_storage_class.mongo_gp3[0].metadata[0].name, kubernetes_storage_class.mongo_gp3_default[0].metadata[0].name)
}
