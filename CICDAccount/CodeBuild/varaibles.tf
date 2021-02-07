variable "name" {
  description = "The name of the Build"
  type        = string
}
variable "tags" {
  type        = map
  description = "An AWS tagging scheme"
}

variable "image" {
  type        = string
}
variable "kms_key_arn" {
  type        = string
}
