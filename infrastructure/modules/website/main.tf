resource "aws_s3_bucket" "static_website_bucket" {
  bucket = var.website_bucket_name
  acl    = "public-read"

  # Prevents errors on destroy if the bucket has items in it
  force_destroy = true

  lifecycle {
    prevent_destroy = false
  }

  website {
    index_document = "index.html"
    error_document = "index.html"
  }
}

resource "aws_s3_bucket_policy" "static_website_policy" {
  bucket = aws_s3_bucket.static_website_bucket.id

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Id": "${aws_s3_bucket.static_website_bucket.id}_policy",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": "*",
      "Action": "s3:*",
      "Resource": "arn:aws:s3:::${aws_s3_bucket.static_website_bucket.id}/*"
    }
  ]
}
POLICY
}

resource "null_resource" "remove_and_upload_to_s3" {
  provisioner "local-exec" {
    command = "aws s3 sync ${var.path_to_folder} s3://${aws_s3_bucket.static_website_bucket.id}"
  }

  depends_on = [aws_s3_bucket.static_website_bucket]
}

# This seems to go bang on the first run - Might have to put something in so that its got a dependency?
output "public_website_url" {
  description = "The target URL of the deployed website"
  value = aws_s3_bucket.static_website_bucket.website_endpoint

  depends_on = [
    aws_s3_bucket.static_website_bucket
  ]
}