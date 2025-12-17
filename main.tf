provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "my_versioned_bucket" {
  bucket = "my-unique-bucket-name"
  acl    = "private"

  versioning {
    enabled = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  lifecycle_rule {
    id = "delete_after_365_days"
    prefix = ""
    status = "Enabled"

    transition {
      days = 90
      storage_class = "GLACIER"
    }

    expiration {
      days = 365
    }
  }
}
