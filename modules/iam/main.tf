data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

locals {
  account_id = data.aws_caller_identity.current.account_id
  region     = data.aws_region.current.name
}

data "aws_iam_policy_document" "pbm_assume" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    principals {
      type = "Federated"
      identifiers = [var.cluster_oidc_provider_arn]
    }
    condition {
      test     = "StringEquals"
      variable = "${replace(var.oidc_provider_url, "https://", "")}:sub"
      values   = ["system:serviceaccount:mongodb:pbm-sa"]
    }
  }
}

resource "aws_iam_role" "pbm" {
  name               = "pbm-irsa-${replace(var.oidc_provider_url, "https://", "")}"
  assume_role_policy = data.aws_iam_policy_document.pbm_assume.json
}

resource "aws_iam_role_policy" "pbm_s3" {
  name   = "pbm-s3-backup"
  role   = aws_iam_role.pbm.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = ["s3:GetObject", "s3:PutObject", "s3:ListBucket", "s3:DeleteObject"]
        Resource = ["arn:aws:s3:::${var.backup_bucket_name}", "arn:aws:s3:::${var.backup_bucket_name}/*"]
      }
    ]
  })
}
