variable "aws_region" {
  description = "AWS region to deploy the S3 bucket"
  type        = string
  default     = "us-east-1"
}

variable "bucket_name" {
  description = "Name of the S3 bucket"
  type        = string
}

variable "logging_bucket_name" {
  description = "Name of the S3 bucket for access logging"
  type        = string
}
