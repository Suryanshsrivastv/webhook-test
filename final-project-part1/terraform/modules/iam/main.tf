resource "aws_iam_role" "backend_ec2" {
  name = "backend-ec2-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action    = "sts:AssumeRole"
      Effect    = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_instance_profile" "backend_ec2" {
  name = "backend-ec2-profile"
  role = aws_iam_role.backend_ec2.name
}

resource "aws_iam_role" "jenkins_ec2" {
  name = "jenkins-ec2-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action    = "sts:AssumeRole"
      Effect    = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_instance_profile" "jenkins_ec2" {
  name = "jenkins-ec2-profile"
  role = aws_iam_role.jenkins_ec2.name
}