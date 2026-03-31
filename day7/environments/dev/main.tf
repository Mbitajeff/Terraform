provider "aws" {
  region = "us-east-1"
}

resource "aws_security_group" "web" {
  name        = "file-layout-sg-dev"
  description = "Dev environment security group"
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
    Name        = "file-layout-sg-dev"
    Environment = "dev"
  }
}

output "sg_id" {
  value       = aws_security_group.web.id
  description = "Dev security group ID"
}

output "environment" {
  value = "dev"
}
