resource "random_id" "suffix" {
    byte_length =   4
}

resource "aws_s3_bucket" "static_site" {
  bucket        = "${var.site_name}-${random_id.suffix.hex}"
  force_destroy = true

  tags = {
    Name        = var.site_name
    Environment = "Production"
  }
}

resource "aws_s3_bucket_website_configuration" "website_config" {
  bucket = aws_s3_bucket.static_site.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "index.html"
  }
}

resource "aws_s3_bucket_public_access_block" "access_block" {
  bucket = aws_s3_bucket.static_site.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "public_read" {
  bucket = aws_s3_bucket.static_site.id

  policy = jsonencode({
    Version = "2012-10-17"
    Id      = "StaticWebPolicy"
    Statement = [
      {
        Sid       = "S3GetObjectAllow"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "${aws_s3_bucket.static_site.arn}/*"
      }
    ]
  })

  depends_on = [aws_s3_bucket_public_access_block.access_block]
}


resource "aws_s3_object" "index_html" {
  bucket       = aws_s3_bucket.static_site.id
  key          = "index.html"
  source       = "${var.site_path}/index.html"
  content_type = "text/html"
}

resource "aws_s3_object" "kerkennah_img" {
  bucket       = aws_s3_bucket.static_site.id
  key          = "kerkennah.jpg"
  source       = "${var.site_path}/kerkennah.jpg"
  content_type = "image/jpeg"
}

resource "aws_s3_object" "cart_img" {
  bucket       = aws_s3_bucket.static_site.id
  key          = "cart.jpg"
  source       = "${var.site_path}/cart.jpg"
  content_type = "image/jpeg"
}