# Copy to backend.hcl and set real values.
bucket         = "YOUR-TFSTATE-BUCKET"
key            = "prod/mongo-eks/terraform.tfstate"
dynamodb_table = "tf-lock"
encrypt        = true
