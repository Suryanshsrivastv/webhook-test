variable "my_ip" {
  type = string
}

variable "db_password" {
  type      = string
  sensitive = true
}

variable "db_name" {
  default = "appdb"
}

variable "ami_id" {
  type = string
}