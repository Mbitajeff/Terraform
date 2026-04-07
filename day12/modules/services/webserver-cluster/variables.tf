variable "cluster_name" {
  description = "Name to use for all cluster resources"
  type        = string
}

variable "ami" {
  description = "AMI ID for EC2 instances"
  type        = string
  default     = "ami-0c02fb55956c7d316"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "min_size" {
  description = "Minimum number of instances in the ASG"
  type        = number
  default     = 2
}

variable "max_size" {
  description = "Maximum number of instances in the ASG"
  type        = number
  default     = 4
}

variable "server_port" {
  description = "Port the server listens on"
  type        = number
  default     = 8080
}

variable "app_version" {
  description = "Version label shown in the HTTP response"
  type        = string
  default     = "v1"
}

variable "active_environment" {
  description = "Which environment receives traffic: blue or green"
  type        = string
  default     = "blue"
}
