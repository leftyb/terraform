

variable "name" {
  description = "The name of the Build"
  type        = string
}
variable "tags" {
  type        = map
  description = "An AWS tagging scheme"
}

variable "repository_name" {
  type        = string
}

variable "branch_name" {
  type        = string
}
variable "project_name" {
  type        = string
}

variable "service_name" {
  type        = string
}

variable "bucket_name" {
  type        = string
}
variable "github_org" {
  type        = string
  
}
variable "github_token" {
  type        = string
}

variable "kms_key_arn" {
  type        = string
  
}

variable "account_prod" {
  type        = string
}

variable "cluster_name_prod" {
  type        = string
  
}
