output "backend_asg_name" {
  value = module.asg-backend.asg_name
}

output "backend_alb_dns_name" {
  value = module.alb.dns_name
}

output "backend_alb_url" {
  value = "http://${module.alb.dns_name}"
}

output "jenkins_public_ip" {
  value = module.jenkins-ec2.jenkins_public_ip
}

output "frontend_website_url" {
  value = module.s3-frontned.website_endpoint
}

output "ecr_repository_url" {
  value = module.ecr.repository_url
}

output "rds_endpoint" {
  value = module.rds.db_endpoint
}