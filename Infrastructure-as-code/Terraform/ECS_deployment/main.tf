module "vpc" {
  source                            = "./modules/virtual_private_network"
  vpc_name                          = var.vpc_configs["vpc_name"]
  aws_vpc_cidr_block                = var.vpc_configs["aws_vpc_cidr_block"]
  dmz_subnets_availability_zone     = var.vpc_configs["dmz_subnets_availability_zone"]
  public_subnets_availability_zone  = var.vpc_configs["public_subnets_availability_zone"]
  private_subnets_availability_zone = var.vpc_configs["private_subnets_availability_zone"]
  private_subnets_cird_list         = var.vpc_configs["private_subnets_cird_list"]
}

module "ecs_cluster" {
  source                         = "./modules/ecs-cluster"
  subnets_id                     = module.vpc.public_subnets
  vpc_id                         = module.vpc.vpc_id
  df_sg                          = module.vpc.public_security_group_id
  cluster_name                   = var.ecs_cluster_configs["cluster_name"]
  instance_type_param            = var.ecs_cluster_configs["instance_type_param"]
  key_name                       = var.ecs_cluster_configs["key_name"]
  ec2_instance_role              = module.iam_roles.ec2_instance_role
  autoscalling_diseried_capacity = var.ecs_cluster_configs["autoscalling_diseried_capacity"]
  autoscalling_max_size          = var.ecs_cluster_configs["autoscalling_max_size"]
  autoscalling_min_size          = var.ecs_cluster_configs["autoscalling_min_size"]
}

module "iam_roles" {
  source = "./modules/iam_roles"
}

module "ecs_task_definition" {
  source    = "./modules/task_definition"
  task_family                = var.ecs_task_definition_configurations["task_family"]
  task_cpu                   = var.ecs_task_definition_configurations["task_cpu"]
  task_memory                = var.ecs_task_definition_configurations["task_memory"]
  image_url                  = var.ecs_task_definition_configurations["image_url"]
  container_definintion_name = var.ecs_task_definition_configurations["container_definintion_name"]
  containerPort              = var.ecs_task_definition_configurations["containerPort"]
  hostPort                   = var.ecs_task_definition_configurations["hostPort"]
  soft_limit                 = var.ecs_task_definition_configurations["soft_limit"]

}

module "service_of_app" {
  source                             = "./modules/service"
  service_name                       = var.ecs_service_config["service_name"]
  service_subnets                    = module.vpc.private_subnets
  serivce_security_group             = module.vpc.public_security_group_id
  cluster_name                       = module.ecs_cluster.cluster_id
  task_def_name                      = module.ecs_task_definition.task_definition_name
  task_def_rev                       = module.ecs_task_definition.task_defintion_revision
  data_task_def_rev                  = module.ecs_task_definition.data_task_defintion_revision
  target_group_arn                   = module.application_loadBalcancer.target_group_arn
  alb_listener_rule                  = module.application_loadBalcancer.alb_listener_rule
  container_port                     = var.ecs_service_config["container_port"]
  continer_name                      = var.ecs_service_config["continer_name"]
  deployment_maximum_percent         = var.ecs_service_config["deployment_maximum_percent"]
  deployment_minimum_healthy_percent = var.ecs_service_config["deployment_minimum_healthy_percent"]
  desired_count                      = var.ecs_service_config["desired_count"]
  health_check_grace_period_seconds  = var.ecs_service_config["health_check_grace_period_seconds"]

}

module "application_loadBalcancer" {
  source              = "./modules/application_loadbalancer"
  subnets_id          = module.vpc.public_subnets
  vpc_id              = module.vpc.vpc_id
  alb_sg              = module.vpc.public_security_group_id
  target_group_name   = var.application_loadbalancer_config["target_group_name"]
  alb_name            = var.application_loadbalancer_config["alb_name"]
  protocol            = var.application_loadbalancer_config["protocol"]
  port                = var.application_loadbalancer_config["port"]
  alb_interval        = var.application_loadbalancer_config["alb_interval"]
  alb_timeout         = var.application_loadbalancer_config["alb_timeout"]
  healthy_threshold   = var.application_loadbalancer_config["healthy_threshold"]
  unhealthy_threshold = var.application_loadbalancer_config["unhealthy_threshold"]

}










