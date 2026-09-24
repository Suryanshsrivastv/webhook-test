output "secret_arn" {
  value = aws_secretsmanager_secret.db.arn
}

output "db_username" {
  value = "admin"
}

output "db_password" {
  value     = var.db_password
  sensitive = true
}