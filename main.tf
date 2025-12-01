provider "aws" {
  region = "us-west-2"
}

resource "aws_s3_bucket" "example" {
  bucket = "terraform-s3-bucket-example"
  acl    = "private"

  tags = {
    Name        = "TerraformS3Bucket"
    Environment = "Development"
  }
}
