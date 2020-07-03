variable "target-group_name" {
  type = "string"
  description = "please enter target group name"
}

variable "subnets_id" {
  type = "list"
  description = "provides subnets list"
}

variable "alb_sg" {
  type = "string"
  description = "please enter target security group name"
}
variable "vpc_id" {
  type = "string"
  description = " enter vpc id "
}