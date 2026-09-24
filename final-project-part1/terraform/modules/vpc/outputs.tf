output "vpc_id" {
  value = aws_vpc.main.id
}

output "public_subnet_app_id" {
  value = aws_subnet.public_app.id
}

output "public_subnet_cicd_id" {
  value = aws_subnet.public_cicd.id
}

output "private_subnet_db_ids" {
  value = [aws_subnet.private_db.id, aws_subnet.private_db2.id]
}