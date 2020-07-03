resource "aws_ecs_service" "app-svc" {
  name                               = var.service_name
  depends_on                         = [var.alb_listener_rule]
  cluster                            = var.cluster_name
  task_definition                    = "${var.task_def_name}:${max("${var.task_def_rev}", "${var.data_task_def_rev}")}"
  desired_count                      = var.desired_count
  launch_type                        = "EC2"
  deployment_maximum_percent         = var.deployment_maximum_percent
  deployment_minimum_healthy_percent = var.deployment_minimum_healthy_percent
  health_check_grace_period_seconds  = var.health_check_grace_period_seconds

  network_configuration {
    security_groups = [var.serivce_security_group]
    subnets         = var.service_subnets
  }

  load_balancer {
    container_name   = var.continer_name
    container_port   = var.container_port
    target_group_arn = var.target_group_arn
  }
}
