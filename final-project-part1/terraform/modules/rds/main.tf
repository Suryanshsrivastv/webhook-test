resource "aws_db_subnet_group" "main" {
  name       = "db-subnet-group"
  subnet_ids = var.private_subnet_ids

  tags = {
    Name = "db-subnet-group"
  }
}

resource "aws_db_instance" "main" {
  identifier             = "backend-db"
  engine                 = "mysql"
  engine_version         = "8.0"
  instance_class         = "db.t3.micro"
  allocated_storage      = 20
  db_name                = "appdb"
  username               = var.db_username
  password               = var.db_password
  db_subnet_group_name   = aws_db_subnet_group.main.name
  vpc_security_group_ids = [var.rds_sg_id]
  multi_az               = false
  publicly_accessible    = false
  skip_final_snapshot    = true

  tags = {
    Name = "backend-db"
  }
}