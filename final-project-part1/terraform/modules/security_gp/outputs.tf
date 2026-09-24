output "backend_sg_id" {
  value = aws_security_group.backend.id
}

output "jenkins_sg_id" {
  value = aws_security_group.jenkins.id
}

output "rds_sg_id" {
  value = aws_security_group.rds.id
}