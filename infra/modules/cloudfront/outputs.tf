output "cloudfront_distribution_arn" {
  value = aws_cloudfront_distribution.cloudfront_distro.arn
}

output "cloudfront_domain_name" {
  value = aws_cloudfront_distribution.cloudfront_distro.domain_name
}

output "cloudfront_hosted_zone_id" {
  value = aws_cloudfront_distribution.cloudfront_distro.hosted_zone_id
}
