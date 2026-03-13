output "master_public_ip" {
    description = "The public IP address of the master node."
    value       = aws_instance.master.public_ip
}

output "master_id" {
    description = "The instance ID of the master node."
    value       = aws_instance.master.id
}

output "worker_id" {
    description = "The instance ID of the worker node."
    value       = aws_instance.worker.id
}
