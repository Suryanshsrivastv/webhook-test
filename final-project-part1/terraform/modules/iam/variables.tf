variable "aws_account_id" {
  type = string
}

variable "aws_region" {
  default = "ap-south-1"
}

variable "db_secret_arn" {
  description = "arn of the rds credentials secret, from secrets_manager module"
  type        = string
}