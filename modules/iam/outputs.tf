output "pbm_irsa_role_arn" {
  description = "IRSA role ARN for Percona Backup for MongoDB S3 access"
  value       = aws_iam_role.pbm.arn
}

output "prometheus_irsa_role_arn" {
  description = "IRSA role ARN for Prometheus (optional)"
  value       = try(aws_iam_role.prometheus[0].arn, null)
}
