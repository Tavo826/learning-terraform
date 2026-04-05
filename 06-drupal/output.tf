output "wordpress_url" {
  description = "URL to access the WordPress application"
  value       = module.ecs.wordpress_url
}

output "db_endpoint" {
  description = "Endpoint of the RDS database"
  value       = module.database.db_endpoint
  sensitive   = true
}

output "vpc_id" {
  description = "ID of the VPC"
  value       = module.network.vpc_id
}