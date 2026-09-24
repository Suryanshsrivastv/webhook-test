resource "aws_instance" "jenkins" {
  ami                    = var.ami_id
  instance_type          = "t3.small"
  subnet_id              = var.subnet_id
  key_name               = "linux-key"
  vpc_security_group_ids = [var.jenkins_sg_id]
  iam_instance_profile   = var.instance_profile_name

  user_data = file("${path.module}/user_data.sh")

  tags = {
    Name = "jenkins-instance"
  }
}