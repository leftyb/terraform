

variable "app_image" {
  description = "Docker image to run in the ECS cluster"
  type        = string
}

variable "app_port" {
  description = "Port exposed by the docker image to redirect traffic to"
  type        = string
}

variable "app_count" {
  description = "Number of docker containers to run"
  type        = string
}


variable "fargate_cpu" {
  description = "Fargate instance CPU units to provision (1 vCPU = 1024 CPU units)"
  type        = string
}

variable "fargate_memory" {
  description = "Fargate instance memory to provision (in MiB)"
  type        = string
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
variable "name-ecs" {
  type = string
}

variable "cluster_name" {
  type = string
}

variable "target_group_arn" {
  
}
variable "security_group_elb_id" {
  
}
variable "vpc_range" {
  
}
