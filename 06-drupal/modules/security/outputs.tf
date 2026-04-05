output "alb_sg_id" {
    description = "The ID of the ALB security group."
    value       = aws_security_group.alb.id
}

output "ecs_tasks_security_group_id" {
  description = "ID of the ECS tasks security group"
  value       = aws_security_group.ecs_tasks.id
}

output "db_security_group_id" {
  description = "ID of the RDS MySQL security group"
  value       = aws_security_group.db.id
}