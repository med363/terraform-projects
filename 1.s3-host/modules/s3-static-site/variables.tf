variable "site_name" {
  description = "Base name of the S3 bucket"
  type        = string
}

variable "region" {
  description = "AWS region"
  type        = string
}

variable "site_path" {
  description = "Path to the static site files"
  type        = string
}