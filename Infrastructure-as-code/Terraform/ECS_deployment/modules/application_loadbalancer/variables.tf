variable "alb_name" {
  type = string
  description = "please tag for application load balancer"
}

variable "target_group_name" {
  type = string
  description = "please enter target group name"
}

variable "subnets_id" {
  type = list
}

variable "alb_sg" {
  type = string
  description = "please enter security group id"
}
variable "vpc_id" {
  type = string
  description = "please enter vpc id"
}

variable "protocol" {
  type = string
  description = "please enter protocol"
}

variable "port" {
  type = number
  description = "port for load balancer"
}

variable "alb_interval" {
  type = number
  description = "interval for health check"
}

variable "alb_timeout" {
  type = number
  description = "timeout for health check"
}

variable "healthy_threshold" {
  type = number
  description = "number of healthy threshold"
}

variable "unhealthy_threshold" {
  type = number
  description = "number of unhealthy threshold"
}

