output "acm_certificate_arn" {
  value = aws_acm_certificate.keysersoze_cert.id
}

output "acm_certificate_status" {
  value = aws_acm_certificate.keysersoze_cert.status
}

output "acm_domain_validation_option_name" {
  value = tolist(aws_acm_certificate.keysersoze_cert.domain_validation_options)[0].resource_record_name
}

output "acm_domain_validation_option_value" {
  value = tolist(aws_acm_certificate.keysersoze_cert.domain_validation_options)[0].resource_record_value
}

output "acm_domain_validation_option_type" {
  value = tolist(aws_acm_certificate.keysersoze_cert.domain_validation_options)[0].resource_record_type
}