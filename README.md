# Terraform  – MongoDB on EKS (from detail.docx)

Terraform native  (`.tftest.hcl`) validate the modular design described in `k8/detail.docx`. No shell or CLI invocations are embedded in Terraform or test files; Kubernetes auth uses the `aws_eks_cluster_auth` data source.

## What is tested

| Location | What it validates |
|----------|-------------------|
| **envs/prod/main.tftest.hcl** | Full composition: network, EKS, backups, IAM, and storage outputs are wired and non-empty. |
| **modules/network/main.tftest.hcl** | VPC CIDR, at least 2 private/public subnets, and correct exports of `private_subnet_ids` / `public_subnet_ids`. |
| **modules/backups/main.tftest.hcl** | S3 backup bucket name prefix, versioning enabled, and `backup_bucket_name` output. |
| **modules/eks/main.tftest.hcl** | EKS cluster name/version, DB node group taint (`role=db:NoSchedule`), cluster endpoint, CA, and OIDC provider for IRSA. |

## Prerequisites

- **Terraform >= 1.6**
- **AWS credentials** configured (e.g. `AWS_PROFILE` or `~/.aws/credentials`)

## How to run

### Prod composition 

From repo root:

```
cd terraform/envs/prod
terraform init
terraform test
```

### Module-level 

From each module directory:

```
cd terraform/modules/network
terraform init
terraform test
```

Repeat for `modules/backups` and `modules/eks`.

## Layout (aligned with detail.docx)

```
terraform/
  envs/prod/           # Root composition + main.tftest.hcl
  modules/
    network/            # VPC, subnets, EKS tags
    eks/                # EKS cluster, db/app node groups, IRSA OIDC
    iam/                # IRSA for PBM (S3), optional Prometheus
    storage/            # StorageClass mongo-gp3-encrypted (EBS CSI)
    backups/            # S3 backup bucket, versioning, encryption
```

## Extending 

- Add more `run` blocks in any `.tftest.hcl` to assert on new outputs or resource attributes.
- Add `.tftest.hcl` under other modules (e.g. `modules/iam`) with `variables` and `assert` blocks.
