output "drupal_url" {
  description = "URL to access the Drupal application"
  value       = module.ecs.drupal_url
}

output "db_endpoint" {
  description = "Endpoint of the RDS database"
  value       = module.database.db_endpoint
}

output "vpc_id" {
  description = "ID of the VPC"
  value       = module.network.vpc_id
}