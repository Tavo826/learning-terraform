output "efs_id" {
  value       = aws_efs_file_system.this.id
  description = "The ID of the EFS file system"
}

output "efs_dns_name" {
  value       = aws_efs_file_system.this.dns_name
  description = "The DNS name of the EFS file system"
}
