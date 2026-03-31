terraform {
  backend "s3" {
    bucket         = "terraform-state-day6-992382477563"
    key            = "day7/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-state-locks"
    encrypt        = true
  }
}

provider "aws" {
  region = "us-east-1"
}

variable "instance_type" {
  description = "EC2 instance type per environment"
  type        = map(string)
  default = {
    dev        = "t2.micro"
    staging    = "t2.small"
    production = "t2.medium"
  }
}

resource "aws_security_group" "web" {
  name        = "web-sg-${terraform.workspace}"
  description = "Security group for ${terraform.workspace} environment"
  vpc_id      = "vpc-050d7a0017ba4cccc"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "web-sg-${terraform.workspace}"
    Environment = terraform.workspace
  }
}

output "environment" {
  value = terraform.workspace
}

output "sg_id" {
  value = aws_security_group.web.id
}

output "instance_type" {
  value = var.instance_type[terraform.workspace]
}
