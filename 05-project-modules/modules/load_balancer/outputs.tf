output "alb_dns" {
    description = "The DNS name of the Application Load Balancer."
    value       = aws_lb.main.dns_name
}

output "alb_arn" {
    description = "The ARN of the Application Load Balancer."
    value       = aws_lb.main.arn
}

output "target_group_arn" {
    description = "The ARN of the ALB target group."
    value       = aws_lb_target_group.tg.arn
}
