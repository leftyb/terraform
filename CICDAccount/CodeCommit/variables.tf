variable "default_branch" {
  description = "The name of the default repository branch	"
  type        = string
}

variable "repository_name" {
  description = "The name of your GIT repository"
  type        = string
}
variable "tags" {
  description = "Common tags applied to all resources, where possible. This would include project code, etc."
  type        = map
}