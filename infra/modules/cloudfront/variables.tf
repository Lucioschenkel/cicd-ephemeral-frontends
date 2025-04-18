variable "origin_domain_name" {
  type        = string
  description = "Origin domain name"
}

variable "aliases" {
  type        = list(string)
  description = "CloudFront aliases"
}

variable "acm_certificate_arn" {
  type        = string
  description = "ACM Certificate ARN"
}

variable "default_root_object" {
  type        = string
  description = "Default root object"
}

variable "cache_policy_name" {
  type        = string
  description = "Cache policy name"
}

variable "cache_policy_comment" {
  type        = string
  description = "Cache policy comment"
}

variable "lambda_edge_arn" {
  type        = string
  description = "Lambda@Edge ARN"
}

variable "lambda_edge_version" {
  type        = string
  description = "Lambda@Edge version"
}

variable "tags" {
  type        = map(string)
  description = "Optional tags"
}

variable "web_acl_id" {
  type        = string
  description = "The ARN of the AWS WAF web ACL to associate with the CloudFront distribution. Note that despite the variable name, CloudFront expects the full ARN."
  default     = null
}
