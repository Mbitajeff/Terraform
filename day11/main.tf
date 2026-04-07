provider "aws" {
  region = "us-east-1"
}

variable "environment" {
  description = "Deployment environment: dev, staging, or production"
  type        = string
  default     = "dev"

  validation {
    condition     = contains(["dev", "staging", "production"], var.environment)
    error_message = "Environment must be dev, staging, or production."
  }
}

variable "enable_detailed_monitoring" {
  description = "Enable CloudWatch detailed monitoring"
  type        = bool
  default     = false
}

locals {
  is_production      = var.environment == "production"
  instance_type      = local.is_production ? "t2.medium" : "t2.micro"
  min_size           = local.is_production ? 3 : 1
  max_size           = local.is_production ? 10 : 3
  enable_monitoring  = local.is_production
}

output "instance_type"     { value = local.instance_type }
output "min_size"          { value = local.min_size }
output "max_size"          { value = local.max_size }
output "enable_monitoring" { value = local.enable_monitoring }

resource "aws_iam_user" "monitoring_user" {
  count = var.enable_detailed_monitoring ? 1 : 0
  name  = "day11-monitoring-${var.environment}"

  tags = {
    Purpose     = "monitoring"
    Environment = var.environment
  }
}

output "monitoring_user_arn" {
  value = var.enable_detailed_monitoring ? aws_iam_user.monitoring_user[0].arn : null
}

variable "use_existing_vpc" {
  description = "If true, look up an existing VPC. If false, define a new one."
  type        = bool
  default     = false
}

variable "existing_vpc_id" {
  description = "VPC ID to use when use_existing_vpc is true"
  type        = string
  default     = ""
}

locals {
  vpc_id = var.use_existing_vpc ? var.existing_vpc_id : "vpc-would-be-created-new"
}

output "vpc_id_in_use" {
  value = local.vpc_id
}

output "deployment_mode" {
  value = var.use_existing_vpc ? "brownfield (existing VPC)" : "greenfield (new VPC)"
}
