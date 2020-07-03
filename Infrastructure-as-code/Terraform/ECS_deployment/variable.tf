variable "region" {
  type        = string
  description = "Enter KeyName for SSH"
}

variable "vpc_configs" {
  description = "vpc configurations"
}

variable "ecs_cluster_configs" {
  description = "cluster configurations"
}

variable "application_loadbalancer_config" {
  description = "Load balancer configurations"
}

variable "ecs_service_config" {
  description = "ECS Service Configurations"
}

variable "ecs_task_definition_configurations" {
  description = "Ecs task Configurations"
}

