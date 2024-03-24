output "s3_bucket_name" {
  value = aws_s3_bucket.keysersoze_bucket1.bucket_domain_name
}

output "s3_bucket_regional_domain_name" {
  value = aws_s3_bucket.keysersoze_bucket1.bucket_regional_domain_name
}

output "s3_bucket_arn" {
  value = aws_s3_bucket.keysersoze_bucket1.arn
}

output "s3_bucket_id" {
  value = aws_s3_bucket.keysersoze_bucket1.id
}

output "s3_bucket_website_configuration_suffix" {
  value = tolist(aws_s3_bucket_website_configuration.keysersoze_bucket1_static.index_document)[0].suffix
}