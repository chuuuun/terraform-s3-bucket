variable "bucket_name" {
  description = "Name of the S3 bucket"
  type        = string
  default     = "unique-s3-bucket-name"
}

variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "transition_days" {
  description = "Number of days after which objects will be transitioned to Glacier"
  type        = number
  default     = 30
}
