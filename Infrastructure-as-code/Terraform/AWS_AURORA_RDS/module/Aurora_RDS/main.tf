resource "aws_security_group" "default" {

  description = "Allow inbound traffic from Security Groups and CIDRs"
  vpc_id      = var.vpc_id

  ingress {
    from_port       = var.db_port
    to_port         = var.db_port
    protocol        = "tcp"
    security_groups = var.security_groups
  }

  ingress {
    from_port   = var.db_port
    to_port     = var.db_port
    protocol    = "tcp"
    cidr_blocks = var.allowed_cidr_blocks
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.name}-${var.environment}-SG"
  }
}


resource "aws_db_subnet_group" "subnet_group" {
  name        = var.name
  description = "For Aurora cluster ${var.name}"
  subnet_ids  = var.subnets
  tags = {
    Name = "Aurora-Subnet-group"
  }
}

resource "aws_db_parameter_group" "slow_query_log_instacne" {
  family = "aurora-mysql5.7"
  description = "slow query logs enabled for instance"
  name = "${var.name}-${var.environment}-db-parameter-group"
  parameter {
    name = "slow_query_log"
    value = 1
    apply_method = "immediate"
  }
  parameter {
    name = "log_output"
    value = "FILE"
    apply_method = "immediate"
  }

}

resource "aws_rds_cluster_parameter_group" "slow_query_log_cluster" {
  family = "aurora-mysql5.7"
  description = "slow query logs enabled for cluster"
  name = "${var.name}-${var.environment}-cluster-paramters-group"
  parameter {
    name = "slow_query_log"
    value = 1
    apply_method = "immediate"
  }
  parameter {
    name = "log_output"
    value = "FILE"
    apply_method = "immediate"
  }

}

resource "aws_rds_cluster" "aurora_cluster" {

  cluster_identifier                  = "${var.name}-rds-cluster-${var.environment}"
  availability_zones                  = var.instance_availability_zone
  database_name                       = var.db_name
  master_username                     = var.admin_user
  master_password                     = var.admin_password
  engine                              = var.engine
  engine_version                      = var.engine_version
  port                                = var.db_port
  vpc_security_group_ids              = compact(flatten([join("", aws_security_group.default.*.id), var.vpc_security_group_ids]))
  deletion_protection                 = var.deletion_protection
  backup_retention_period             = var.backup_retention_period
  preferred_backup_window             = var.preferred_backup_window
  preferred_maintenance_window        = var.preferred_maintenance_window
  enabled_cloudwatch_logs_exports     = var.enabled_cloudwatch_logs_exports
  db_subnet_group_name                = aws_db_subnet_group.subnet_group.name
  db_cluster_parameter_group_name     = aws_rds_cluster_parameter_group.slow_query_log_cluster.name
  skip_final_snapshot                 = true

}

resource "aws_rds_cluster_instance" "aurora_cluster_instances" {
  count                               = var.server_count
  identifier                          = "${var.name}-${count.index + 1}-${var.environment}"
  cluster_identifier                  = aws_rds_cluster.aurora_cluster.id
  engine                              = var.engine
  engine_version                      = var.engine_version
  instance_class                      = var.instance_type
  publicly_accessible                 = var.publicly_accessible
  db_subnet_group_name                = aws_db_subnet_group.subnet_group.name
  db_parameter_group_name             = aws_db_parameter_group.slow_query_log_instacne.name
  preferred_maintenance_window        = var.preferred_maintenance_window
  apply_immediately                   = var.apply_immediately
  monitoring_interval                 = var.rds_monitoring_interval
//monitoring_role_arn                 = var.rds_monitoring_role_arn
  availability_zone                   = var.instance_availability_zone[0]

}

