output "task_definition_name" {
  value = aws_ecs_task_definition.task_defintion.family
}

output "task_defintion_revision" {
  value = aws_ecs_task_definition.task_defintion.revision
}

output "data_task_defintion_revision" {
  value = data.aws_ecs_task_definition.task_defintion_php.revision
}
