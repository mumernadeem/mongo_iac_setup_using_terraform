# Network module tests - VPC, subnets, EKS tags

variables {
  vpc_cidr = "10.0.0.0/16"
  azs      = ["us-east-1a", "us-east-1b", "us-east-1c"]
  env      = "prod"
}

run "network_outputs_exist" {
  assert {
    condition     = length(aws_subnet.private) >= 2
    error_message = "Must have at least 2 private subnets across AZs."
  }

  assert {
    condition     = length(aws_subnet.public) >= 2
    error_message = "Must have at least 2 public subnets for NAT/LB."
  }

  assert {
    condition     = aws_vpc.main.cidr_block == var.vpc_cidr
    error_message = "VPC CIDR must match input vpc_cidr."
  }
}

run "network_outputs_exported" {
  assert {
    condition     = length(private_subnet_ids) == length(aws_subnet.private)
    error_message = "private_subnet_ids output must include all private subnets."
  }

  assert {
    condition     = length(public_subnet_ids) == length(aws_subnet.public)
    error_message = "public_subnet_ids output must include all public subnets."
  }
}
