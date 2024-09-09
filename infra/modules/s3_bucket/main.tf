resource "aws_s3_bucket" "bucket" {
  bucket = var.bucket_name

  tags = var.tags
}

resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.bucket.bucket

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "lifecycle" {
  bucket = aws_s3_bucket.bucket.bucket

  rule {
    id     = "expire-previous-versions"
    status = "Enabled"

    expiration {
      days = var.object_expiration_days
    }
  }
}
