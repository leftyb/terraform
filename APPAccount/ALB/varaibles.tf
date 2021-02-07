
variable "app_port" {
  description = "Port exposed by the docker image to redirect traffic to"
  type        = string
}
variable "health_check_path" {
  type = string
}
variable "vpc_id" {
  type = string
}
variable "name" {
  type = string
}
variable "public_subnet_ids" {
  type = list
}
variable "private_subnet_ids" {
  type = list
}
variable "tags" {
  type = map
}
variable "region" {
  type = string
}
variable "internal" {
   type = string
}

output "aws_alb_target_group" {
  value = aws_alb_target_group.app.arn
}
output "aws_lb" {
  value = aws_alb.main.arn
}
output "security_group_elb_id" {
  value = aws_security_group.lb.id
}
