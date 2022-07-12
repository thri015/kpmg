resource "aws_s3_bucket" "bucket" {
  bucket = var.name

  tags = var.tags
}

resource "aws_s3_bucket_acl" "example" {
  bucket = aws_s3_bucket.bucket.id
  acl    = "private"
}

