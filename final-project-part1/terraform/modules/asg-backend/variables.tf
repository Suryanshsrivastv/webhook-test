variable "ami_id" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "backend_sg_id" {
  type = string
}

variable "instance_profile_name" {
  type = string
}

variable "ecr_repo_url" {
  type = string
}

variable "aws_region" {
  default = "ap-south-1"
}

variable "db_secret_arn" {
  type = string
}

variable "db_host" {
  type = string
}

variable "db_name" {
  type = string
}