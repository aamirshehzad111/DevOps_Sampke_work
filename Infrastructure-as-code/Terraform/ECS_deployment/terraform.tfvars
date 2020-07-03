region            = "us-east-1"
image_url         = "020046395185.dkr.ecr.us-east-1.amazonaws.com/php-apache-image:latest"
target-group_name = "tg1"

vpc_configs = {
  "vpc_name"                          = "custom-vpc",
  "aws_vpc_cidr_block"                = "10.0.0.0/16",
  "dmz_subnets_availability_zone"     = ["us-east-1a", "us-east-1b"],
  "public_subnets_availability_zone"  = ["us-east-1e", "us-east-1c"],
  "private_subnets_availability_zone" = ["us-east-1f", "us-east-1d"],
  "private_subnets_cird_list"         = ["10.0.64.3/20", "10.0.16.1/20"]
}

ecs_cluster_configs = {
  "cluster_name"                   = "php_cluster",
  "instance_type_param"            = "t2.medium",
  "key_name"                       = "aamirKP1"
  "autoscalling_diseried_capacity" = 3,
  "autoscalling_max_size"          = 5,
  "autoscalling_min_size"          = 1
}

application_loadbalancer_config = {
  target_group_name   = "service-target-group",
  alb_name            = "service-loadbalancer-name",
  protocol            = "HTTP",
  port                = 80,
  alb_interval        = 6,
  alb_timeout         = 5,
  healthy_threshold   = 2,
  unhealthy_threshold = 2

}

ecs_service_config = {
  "service_name"                       = "test_service",
  "continer_name"                      = "php-apache",
  "container_port"                     = 80,
  "deployment_maximum_percent"         = 200,
  "deployment_minimum_healthy_percent" = 100,
  "desired_count"                      = 2,
  "health_check_grace_period_seconds"  = 60
}

ecs_task_definition_configurations = {
  "task_family"                = "task-terraform-php",
  "task_cpu"                   = 512,
  "task_memory"                = 1024
  "image_url"                  = "php-apache",
  "container_definintion_name" = "php-apache",
  "containerPort"              = 80,
  "hostPort"                   = 0,
  "soft_limit"                 = 256,
}