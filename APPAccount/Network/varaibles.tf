
variable "az_count" {
  description = "Number of AZs to cover in a given region"
  type = string
}
variable "cidr_block" {
  type = string
}
variable "tags" {
  description = "Common tags applied to all resources, where possible. This would include project code, etc."
  type        = map
}