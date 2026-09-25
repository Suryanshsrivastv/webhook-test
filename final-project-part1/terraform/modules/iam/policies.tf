resource "aws_iam_role_policy_attachment" "backend_ecr_pull" {
  role       = aws_iam_role.backend_ec2.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

resource "aws_iam_role_policy_attachment" "backend_ssm" {
  role       = aws_iam_role.backend_ec2.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_role_policy" "backend_secrets" {
  name = "backend-secrets-access"
  role = aws_iam_role.backend_ec2.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect   = "Allow"
      Action   = "secretsmanager:GetSecretValue"
      Resource = var.db_secret_arn
    }]
  })
}

resource "aws_iam_role_policy_attachment" "jenkins_ecr_push" {
  role       = aws_iam_role.jenkins_ec2.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryPowerUser"
}

resource "aws_iam_role_policy" "jenkins_asg_describe" {
  name = "jenkins-asg-describe"
  role = aws_iam_role.jenkins_ec2.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect   = "Allow"
      Action   = "autoscaling:DescribeAutoScalingGroups"
      Resource = "*"
    }]
  })
}

resource "aws_iam_role_policy" "jenkins_ssm_send" {
  name = "jenkins-ssm-send-command"
  role = aws_iam_role.jenkins_ec2.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = "ssm:SendCommand"
        Resource = "arn:aws:ssm:${var.aws_region}::document/AWS-RunShellScript"
      },
      {
        Effect   = "Allow"
        Action   = "ssm:SendCommand"
        Resource = "arn:aws:ec2:${var.aws_region}:${var.aws_account_id}:instance/*"
        Condition = {
          StringEquals = {
            "ssm:resourceTag/Name" = "backend-instance"
          }
        }
      },
      {
        Effect   = "Allow"
        Action   = "ssm:GetCommandInvocation"
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy" "jenkins_s3" {
  name = "jenkins-s3-frontend-write"
  role = aws_iam_role.jenkins_ec2.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect   = "Allow"
      Action   = ["s3:PutObject", "s3:DeleteObject", "s3:ListBucket"]
      Resource = [
        "arn:aws:s3:::frontend-bucket-20260924045231568500000002",
        "arn:aws:s3:::frontend-bucket-20260924045231568500000002/*"
      ]
    }]
  })
}

resource "aws_iam_role_policy_attachment" "jenkins_ssm_core" {
  role       = aws_iam_role.jenkins_ec2.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}