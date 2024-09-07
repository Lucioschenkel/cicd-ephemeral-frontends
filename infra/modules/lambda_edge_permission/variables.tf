variable "function_name" {
  type        = string
  description = "Lambda@Edge function name"
}

variable "cloudfront_distribution_arn" {
  type        = string
  description = "CloudFront distribution ARN"
}
