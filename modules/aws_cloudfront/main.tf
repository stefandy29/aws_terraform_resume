resource "aws_cloudfront_origin_access_control" "keysersoze_bucket1_oac" {
  name                              = var.bucket_name
  description                       = "Cloud Front S3 OAC"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

resource "aws_cloudfront_distribution" "keysersoze_bucket1_distrib" {
  origin {
    domain_name              = var.bucket_regional_domain_name
    origin_id                = var.cloudfront_origin_id
    origin_access_control_id = aws_cloudfront_origin_access_control.keysersoze_bucket1_oac.id
  }

  enabled             = true
  is_ipv6_enabled     = true
  comment             = "Some comment"
  default_root_object = "index.html"
  aliases             = [var.cloudfront_alias]

  default_cache_behavior {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = var.cloudfront_origin_id
    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }
  ordered_cache_behavior {
    path_pattern     = "*"
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = var.cloudfront_origin_id
    cache_policy_id = "4135ea2d-6df8-44a3-9df3-4b5a84be39ad" #hardcoded id from aws to set caching disabled

    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
    viewer_protocol_policy = "redirect-to-https"
  }

  viewer_certificate {
    acm_certificate_arn      = var.acm_certificate_arn
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1"
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
      locations        = []
    }
  }
}
