variable "vpc_cidr" {
  default = "10.0.0.0/24"
}

variable "public_subnet_app_cidr" {
  default = "10.0.0.0/27"
}

variable "public_subnet_cicd_cidr" {
  default = "10.0.0.32/27"
}

variable "public_subnet_alb_cidr" {
  default = "10.0.0.128/27"
}

variable "private_subnet_db_cidr" {
  default = "10.0.0.64/27"
}

variable "availability_zone" {
  default = "ap-south-1a"
}

variable "private_subnet_db2_cidr" {
  default = "10.0.0.96/27"
}

variable "availability_zone_2" {
  default = "ap-south-1b"
}