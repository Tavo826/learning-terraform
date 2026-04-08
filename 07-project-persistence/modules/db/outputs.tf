output "db_endpoint" {
  value       = aws_db_instance.this.endpoint
  description = "The connection endpoint of the RDS instance"
}

output "db_name" {
  value       = aws_db_instance.this.db_name
  description = "The name of the database"
}

output "db_username" {
  value       = aws_db_instance.this.username
  description = "The master username for the database"
}
