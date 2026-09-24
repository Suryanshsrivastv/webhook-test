output "backend_instance_profile_name" {
  value = aws_iam_instance_profile.backend_ec2.name
}

output "jenkins_instance_profile_name" {
  value = aws_iam_instance_profile.jenkins_ec2.name
}