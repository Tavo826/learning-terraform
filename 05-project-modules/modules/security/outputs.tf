output "sg_master_id" {
    description = "The ID of the master node security group."
    value       = aws_security_group.master.id
}

output "sg_worker_id" {
    description = "The ID of the worker node security group."
    value       = aws_security_group.worker.id
}
