output "sg_master_id" {
    description = "The ID of the master node security group."
    value       = aws_security_group.master.id
}

output "sg_worker_id" {
    description = "The ID of the worker node security group."
    value       = aws_security_group.worker.id
}

output "alb_sg_id" {
    description = "The ID of the ALB security group."
    value       = aws_security_group.alb.id
}
