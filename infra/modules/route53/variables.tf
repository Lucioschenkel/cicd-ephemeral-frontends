variable "hosted_zone_id" {
  type        = string
  description = "Hosted zone ID"
}

variable "domain_name" {
  type        = string
  description = "Domain name"
}

variable "cloudfront_domain" {
  type        = string
  description = "CloudFront domain"
}

variable "cloudfront_hosted_zone_id" {
  type        = string
  description = "CloudFront hosted zone ID"
}
