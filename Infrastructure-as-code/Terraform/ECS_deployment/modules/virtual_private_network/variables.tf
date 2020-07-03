variable "vpc_name" {
  type        = "string"
  default     = "vpc_tf"
  description = "Name of the vpc"
}

variable "aws_vpc_cidr_block" {
  type        = "string"
  default     = "10.0.0.0/16"
  description = "vpc cidr block"
}

variable "dmz_subnets_cird_list" {
  type = list(string)
  description = "List down the cidr block for dmz subnets"
  default = []
}

variable "dmz_subnets_availability_zone" {
  type = list(string)
  description = "List down availability_zone in which you want to create DMZ subnets"
  default = ["us-east-1e", "us-east-1f"]
}

variable "public_subnets_cird_list" {
  type = list(string)
  description = "List down the cidr block for public subnets"
  default = []
}

variable "public_subnets_availability_zone" {
  type = list(string)
  description = "List down availability_zone in which you want to create public subnets"
  default = ["us-east-1a", "us-east-1b"]
}

variable "private_subnets_cird_list" {
  type = list(string)
  description = "List down the cidr block for private subnets"
  default = []
}

variable "private_subnets_availability_zone" {
  type = list(string)
  description = "List down availability_zone in which you want to create private subnets"
  default = ["us-east-1c", "us-east-1d"]
}