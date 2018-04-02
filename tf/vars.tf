variable "appname" {
  default = "sigma-server"
}

variable "host_port" {
  default = 8080
}

variable "docker_port" {
  default = 8080
}

variable "lb_port" {
  default = 80
}

variable "aws_region" {
  default = "eu-west-1"
}

variable "key_name" {
  default = "sigma-server"
}

variable "dockerimg" {
  default = "karlson/sigma-server"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "ami" {
  default = "ami-bfb5fec6"
}

variable "vpc" {
  default = "vpc-fb19979d"
}

variable "public_subnets" {
  default = ["subnet-79a17e1f", "subnet-4aacb211", "subnet-5d4fe215"]
}
