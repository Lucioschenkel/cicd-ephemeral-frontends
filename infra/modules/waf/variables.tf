variable "acl_name_prefix" {
  type        = string
  description = "Prefix for the WAF Web ACL name"
}

variable "rate_limit" {
  type        = number
  description = "The maximum number of requests allowed from a single IP address in a five-minute period"
  default     = 2000
}

variable "tags" {
  type        = map(string)
  description = "A map of tags to assign to the WAF resources"
  default     = {}
}

