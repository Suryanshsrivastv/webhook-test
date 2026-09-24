resource "aws_secretsmanager_secret" "db" {
  name        = "rds-db-credentials"
  description = "mysql credentials for backend app"

  tags = {
    Name = "rds-db-credentials"
  }
}

resource "aws_secretsmanager_secret_version" "db" {
  secret_id = aws_secretsmanager_secret.db.id

  secret_string = jsonencode({
    username = "admin"
    password = var.db_password
  })
}