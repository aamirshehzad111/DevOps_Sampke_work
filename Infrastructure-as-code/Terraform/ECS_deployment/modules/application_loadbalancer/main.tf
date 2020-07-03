resource "aws_alb" "loadbalacner" {
  subnets = var.subnets_id
  security_groups = [var.alb_sg]
  tags = {
    Name = var.alb_name
  }
}

resource "aws_alb_target_group" "targeting_group" {
  name = var.target_group_name
  target_type = "instance"
  port = 80
  protocol = var.protocol
  vpc_id = var.vpc_id
    
  health_check {
    interval = var.alb_interval
    protocol = var.protocol
    path = "/"
    timeout = var.alb_timeout
    healthy_threshold = var.healthy_threshold
    unhealthy_threshold = var.unhealthy_threshold
  }

}

resource "aws_alb_listener" "loadbalancer_listener" {
  load_balancer_arn = aws_alb.loadbalacner.arn
  port = var.port
  protocol = var.protocol
  default_action {
    type = "forward"
    target_group_arn = aws_alb_target_group.targeting_group.arn
  }
}

resource "aws_alb_listener_rule" "loadbalancer_listener_rule" {
  listener_arn = aws_alb_listener.loadbalancer_listener.arn
  action {
    type = "forward"
    target_group_arn = aws_alb_target_group.targeting_group.arn
  }
  condition {
    field = "path-pattern"
    values = ["*"]
  }
  priority = 1
}