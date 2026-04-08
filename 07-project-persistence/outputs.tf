output "db_endpoint" {
  value       = module.database.db_endpoint
  description = "The connection endpoint of the RDS instance"
}

output "db_name" {
  value       = module.database.db_name
  description = "The name of the database"
}

output "efs_id" {
  value       = module.storage.efs_id
  description = "The ID of the EFS file system"
}

output "efs_dns_name" {
  value       = module.storage.efs_dns_name
  description = "The DNS name of the EFS file system"
}
