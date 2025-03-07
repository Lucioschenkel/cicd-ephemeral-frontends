variable "project_name" {
  type        = string
  description = "Project name"
}

variable "project_domain" {
  type        = string
  description = "Wildcard domain used for the project, e.g. *.example.com"
}

variable "hosted_zone_id" {
  type        = string
  description = "Route53 Hosted zone ID. This Terraform stack won't provision a hosted zone. One must already be present in your AWS account"
}

variable "bucket_objects_expiration_days" {
  type        = number
  description = "Number of days to keep previous versions of objects"
  default     = 7
}

variable "default_project_tags" {
  type        = map(string)
  description = "Default tags for resources"
  default = {
    "Iac"     = "Terraform"
    "Project" = "Ephemeral Frontends"
  }
}
