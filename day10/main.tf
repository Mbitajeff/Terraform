provider "aws" {
  region = "us-east-1"
}

variable "user_names" {
  type    = set(string)
  default = ["alice", "bob", "charlie"]
}

variable "users" {
  type = map(object({
    department = string
    admin      = bool
  }))
  default = {
    alice = { department = "engineering", admin = true }
    bob   = { department = "marketing",   admin = false }
    carol = { department = "engineering", admin = false }
  }
}

variable "environment" {
  type    = string
  default = "dev"
}

variable "enable_admin_user" {
  type    = bool
  default = true
}

resource "aws_iam_user" "foreach_example" {
  for_each = var.user_names
  name     = "day10-fe-${each.value}"
}

resource "aws_iam_user" "map_example" {
  for_each = var.users
  name     = "day10-map-${each.key}"
  tags = {
    Department = each.value.department
    Admin      = tostring(each.value.admin)
  }
}

locals {
  instance_type = var.environment == "production" ? "t2.medium" : "t2.micro"
}

resource "aws_iam_user" "admin" {
  count = var.enable_admin_user ? 1 : 0
  name  = "day10-admin-${var.environment}"
  tags = {
    Role        = "admin"
    Environment = var.environment
  }
}

output "foreach_user_arns" {
  value = { for name, user in aws_iam_user.foreach_example : name => user.arn }
}

output "map_user_arns" {
  value = { for name, user in aws_iam_user.map_example : name => user.arn }
}

output "engineering_users" {
  value = [for name, user in var.users : name if user.department == "engineering"]
}

output "instance_type" {
  value = local.instance_type
}

output "admin_user_arn" {
  value = var.enable_admin_user ? aws_iam_user.admin[0].arn : "admin user disabled"
}

# -----------------------------------------------
# PART 6: Refactored webserver module with conditionals
# -----------------------------------------------
variable "enable_autoscaling" {
  description = "Enable autoscaling policies"
  type        = bool
  default     = true
}

module "webserver_cluster" {
  source = "../day8/modules/services/webserver-cluster"

  cluster_name       = "day10-webserver"
  vpc_id             = "vpc-050d7a0017ba4cccc"
  subnet_ids         = ["subnet-085ee38907f4c6d84", "subnet-0e7192648a1091460"]
  ami_id             = "ami-05024c2628f651b80"
  instance_type      = local.instance_type
  min_size           = 2
  max_size           = 4
  server_port        = 8080
  enable_autoscaling = var.enable_autoscaling
}
