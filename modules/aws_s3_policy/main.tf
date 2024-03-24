resource "aws_s3_bucket_policy" "keysersoze_bucket1_policy" {
  bucket = var.s3_bucket_id
  policy = data.aws_iam_policy_document.keysersoze_bucket1_json_policy.json
}

data "aws_iam_policy_document" "keysersoze_bucket1_json_policy" {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["${var.s3_bucket_arn}/*"]
    principals {
      type        = "Service"
      identifiers = ["cloudfront.amazonaws.com"]
    }
    condition {
      test     = "StringEquals"
      variable = "AWS:SourceArn"
      values   = [var.cloudfront_distrib_arn]
    }
  }
}