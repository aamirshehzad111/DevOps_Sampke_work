variable "task_family" {
  type = string
  description = "ecs task family"
}

variable "task_memory" {
  type = string
  description = "task memory"
}

variable "task_cpu" {
  type = string
  description = "task cpu"
}

variable "image_url" {
  type = string
  description = "Eneter image url please"
}

variable "network" {
  type = string
  description = "container netwok type"
  default = "awsvpc"
}

variable "container_definintion_name" {
  type = string
  description = "name for container"
}

variable "soft_limit" {
  type = number
  description = "soft liimit for container"
}
variable "containerPort" {
  type = number
  description = "container port"
}

variable "hostPort" {
  type = number
  description = "host port"
}