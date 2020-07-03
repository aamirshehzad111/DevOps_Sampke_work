variable "region" {
  description   = "AWS Region to launch"
  type          = string
  default       = "us-east-1"
}

variable "load_balancer_config" {
  description = "load balancer configurations"
}
