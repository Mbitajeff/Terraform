provider "aws" {
  region = "us-east-1"
}

resource "aws_security_group" "web" {
  name        = "file-layout-sg-production"
  description = "Production environment security group"
  vpc_id      = "vpc-050d7a0017ba4cccc"

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

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
    Name        = "file-layout-sg-production"
    Environment = "production"
  }
}

output "sg_id" {
  value       = aws_security_group.web.id
  description = "Production security group ID"
}

output "environment" {
  value = "production"
}

data "terraform_remote_state" "dev" {
  backend = "s3"
  config = {
    bucket = "terraform-state-day6-992382477563"
    key    = "environments/dev/terraform.tfstate"
    region = "us-east-1"
  }
}

output "dev_sg_id" {
  value       = data.terraform_remote_state.dev.outputs.sg_id
  description = "Dev SG ID read from remote state"
}
