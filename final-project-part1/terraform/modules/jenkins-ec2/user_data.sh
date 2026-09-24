#!/bin/bash

dnf update -y

dnf install -y java-21-amazon-corretto

dnf install -y maven


dnf install -y docker
systemctl enable docker
systemctl start docker

usermod -aG docker ec2-user

dnf install -y wget

wget -O /etc/yum.repos.d/jenkins.repo \
https://pkg.jenkins.io/redhat-stable/jenkins.repo

rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key

dnf install -y jenkins

usermod -aG docker jenkins

systemctl enable jenkins
systemctl start jenkins

systemctl restart docker
