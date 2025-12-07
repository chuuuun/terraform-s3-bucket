provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "s3_bucket" {
  bucket = "unique-s3-bucket-name"
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
    id      = "log_cleanup"
    prefix  = "logs/"
    enabled = true

    transition {
      days          = 30
      storage_class = "GLACIER"
    }
  }

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Deny"
        Principal = "*"
        Action = "s3:PutObject"
        Resource = "arn:aws:s3:::unique-s3-bucket-name/*"
        Condition = {
          Bool = {
            "aws:SecureTransport" = false
          }
        }
      },
      {
        Effect = "Deny",
        Principal = "*",
        Action = "s3:*",
        Resource = [
          "arn:aws:s3:::unique-s3-bucket-name",
          "arn:aws:s3:::unique-s3-bucket-name/*"
        ],
        Condition = {
          StringNotLike = {
            "aws:arn" = [
              "arn:aws:iam::123456789012:role/terraform-state-role",
              "arn:aws:iam::123456789012:user/terraform-user"
            ]
          }
        }
      }
    ]
  })
}

terraform {
  backend "s3" {
    bucket = "unique-s3-bucket-name"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}
