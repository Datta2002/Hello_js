variable "vpc_cidr" {
  default = "172.31.0.0/16"
}

variable "subnet_cidr_a" {
  default = "172.31.16.0/20"
}

variable "subnet_cidr_b" {
  default = "172.31.32.0/20"
}

variable "container_port" {
  default = 3000
}
