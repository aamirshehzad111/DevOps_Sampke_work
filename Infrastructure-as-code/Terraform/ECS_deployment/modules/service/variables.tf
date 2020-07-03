variable "service_name" {
  type        = string
  description = "please enter service name"
}

variable "cluster_name" {
  type        = string
  description = "please enter cluster name"
}

variable "task_def_name" {
  type        = string
  description = "please enter task definiton name"
}

variable "task_def_rev" {
  type = string
}

variable "data_task_def_rev" {
  type = string
}

variable "target_group_arn" {
  type        = string
  description = "please enter target group name"
}

variable "alb_listener_rule" {
  type        = string
  description = "please enter alb listener rule for service"
}

variable "iam_service_role" {
  type        = string
  description = "please link service name"
  default     = ""
}

variable "serivce_security_group" {
  type        = string
  description = "please enter secuirt group name"
}

variable "service_subnets" {
  type        = list
  description = "please enter subnets"
}

variable "container_port" {
  type        = number
  description = "container port for alb"
}

variable "continer_name" {
  type        = string
  description = "container name for load balancing"
}

variable "desired_count" {
  type        = number
  description = "desired count: number of task you want run on a serivec"
}

variable "deployment_maximum_percent" {
  type        = number
  description = "maximum deployment percent"
}

variable "deployment_minimum_healthy_percent" {
  type        = number
  description = "minimum healthy deployment percent"
}

variable "health_check_grace_period_seconds" {
  type        = number
  description = "health check grace period"

}