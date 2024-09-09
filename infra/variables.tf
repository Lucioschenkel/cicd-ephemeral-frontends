variable "project_name" {
  type        = string
  description = "Project name"
  default     = "ephemeral-frontends"
}

variable "project_domain" {
  type        = string
  description = "Project domain"
  default     = "*.ephemeral-frontends.open-management.me"
}

variable "hosted_zone_id" {
  type        = string
  description = "Hosted zone ID"
  default     = "Z09500171G8Q18EXQSX4Z"
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
