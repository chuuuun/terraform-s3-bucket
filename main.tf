provider "aws" {
  region = var.aws_region
}

resource "aws_s3_bucket" "s3_bucket" {
  bucket = var.bucket_name
  acl    = "private"

  # Block public access
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true

  # Enable versioning
  versioning {
    enabled = true
  }

  # Enable server-side encryption
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  # Enable access logging
  logging {
    target_bucket = var.logging_bucket_name
    target_prefix = "logs/"
  }

  # Lifecycle rules
  lifecycle_rules {
    id      = "transition-to-glacier"
    prefix  = ""
    enabled = true

    transitions {
      days          = 90
      storage_class = "GLACIER"
    }
  }
}
