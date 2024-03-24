output "cloudfront_distrub_arn" {
  value = aws_cloudfront_distribution.keysersoze_bucket1_distrib.arn
}

output "cloudfront_distrub_domain_name" {
  value = aws_cloudfront_distribution.keysersoze_bucket1_distrib.domain_name
}