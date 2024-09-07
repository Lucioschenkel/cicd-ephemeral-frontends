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
