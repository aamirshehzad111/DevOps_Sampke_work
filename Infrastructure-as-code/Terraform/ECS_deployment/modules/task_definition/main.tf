data "aws_ecs_task_definition" "task_defintion_php" {
  depends_on = [ "aws_ecs_task_definition.task_defintion_php" ]
  task_definition = aws_ecs_task_definition.task_defintion.family
}

resource "aws_ecs_task_definition" "task_defintion" {

  family = var.task_family
  requires_compatibilities = ["EC2"]
  network_mode = "bridge"
  cpu          = var.task_cpu
  memory       = var.task_memory

  container_definitions = <<DEFINITION
  [
  {
          "name": "${var.container_definintion_name}",
          "image": "${var.image_url}",
          "memoryReservation": ${var.soft_limit},
          "portMappings" : [
            {
              "containerPort": ${var.containerPort},
              "hostPort": ${var.hostPort}
            }
          ]

  },
  {
          "name":  "mysql-php",
          "image": "mysql:latest",
          "portMappings" : [
            {
              "containerPort": 3306,
              "hostPort": 0
            }
          ],
          "memoryReservation": 256,
          "environment": [
            {
              "name": "MYSQL_ROOT_PASSWORD",
              "value": "er12345678"
            }
          ]
  }
  ]
  DEFINITION

}