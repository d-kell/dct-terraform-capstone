output "db_endpoint_address" {
  description = "The endpoint (address only) of the RDS instance"
  value       = aws_db_instance.dev_db.address
}

output "port" { value = aws_db_instance.dev_db.port }

output "arn" { value = aws_db_instance.dev_db.arn }

output "db_endpoint" {
  description = "The endpoint (address only) of the RDS instance"
  value       = aws_db_instance.dev_db.endpoint
}
