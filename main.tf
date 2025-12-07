provider "aws" {
  region = "us-east-1"
  default_tags {
    tags = {
      Environment = "dev"
    }
  }
  # Enforce secure defaults
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket" "secure_bucket" {
  bucket = "secure-s3-bucket-example"
  acl    = "private"

  # Enable encryption at rest using S3-managed keys
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  # Enable versioning for robust data management
  versioning {
    enabled = true
  }

  # Enable logging if needed
  # logging {
  #   target_bucket = "log-bucket-name"
  #   target_prefix = "log/"
  # }

  # Enable lifecycle rules for cost optimization
  # lifecycle_rule {
  #   id = "transition"
  #   enabled = true
  #   transition {
  #     days = 30
  #     storage_class = "STANDARD_IA"
  #   }
  # }
}
