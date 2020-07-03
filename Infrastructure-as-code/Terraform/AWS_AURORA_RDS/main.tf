module "aurora_and_cw" {

  source = "./module/Aurora_RDS"
  region                                = var.region
  server_count                          = var.server_count
  name                                  = var.name
  environment                           = var.environment
  db_name                               = var.db_name
  db_port                               = var.db_port
  instance_type                         = var.instance_type
  vpc_id                                = var.vpc_id
  engine                                = var.engine
  admin_user                            = var.admin_user
  admin_password                        = random_password.admin_pasoword.result
  allowed_cidr_blocks                   = var.allowed_cidr_blocks
  subnets                               = var.subnets
  security_groups                       = var.security_groups
  vpc_security_group_ids                = var.security_groups
  enabled_cloudwatch_logs_exports       = var.enabled_cloudwatch_logs_exports
  rds_monitoring_interval               = var.rds_monitoring_interval
  rds_monitoring_role_arn               = var.rds_monitoring_role_arn
  instance_availability_zone            = var.instance_availability_zone
  dashboard_name                        = var.dashboard_name
  pattern_name                          = var.pattern_name
}

resource "random_password" "admin_pasoword" {
  length = 10
  special = false
}

