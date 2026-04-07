variable "cluster_name" {
  type    = string
  default = "day12"
}

variable "ami" {
  type    = string
  default = "ami-0c7217cdde317cfec"
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "server_port" {
  type    = number
  default = 80
}

variable "min_size" {
  type    = number
  default = 2
}

variable "max_size" {
  type    = number
  default = 4
}

variable "app_version" {
  type    = string
  default = "v1"
}
