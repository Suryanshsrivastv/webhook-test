#!/bin/bash
yum update -y
yum install -y docker jq
systemctl start docker
systemctl enable docker

aws ecr get-login-password --region ${aws_region} | docker login --username AWS --password-stdin ${ecr_repo_url}

docker pull ${ecr_repo_url}:latest

SECRET=$(aws secretsmanager get-secret-value --secret-id ${db_secret_arn} --region ${aws_region} --query SecretString --output text)
DB_USER=$(echo $SECRET | jq -r .username)
DB_PASSWORD=$(echo $SECRET | jq -r .password)

docker run -d \
  --name backend-app \
  --restart unless-stopped \
  -p 8080:8080 \
  -e DB_HOST=${db_host} \
  -e DB_NAME=${db_name} \
  -e DB_USER=$DB_USER \
  -e DB_PASSWORD=$DB_PASSWORD \
  ${ecr_repo_url}:latest