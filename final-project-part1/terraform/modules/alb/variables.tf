variable "vpc_id" {
  type = string
}

variable "subnet_ids" {
  type = list(string)
}

variable "alb_sg_id" {
  type = string
}

variable "asg_name" {
  type = string
}

variable "health_check_path" {
  type    = string
  default = "/"
}