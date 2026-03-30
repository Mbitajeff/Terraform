terraform {
  backend "s3" {
    bucket         = "terraform-state-day6-992382477563"
    key            = "day6/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-state-locks"
    encrypt        = true
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_security_group" "day6_sg" {
  name        = "day6-sg"
  description = "Day 6 state management demo"

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
    Name = "day6-demo"
    Day  = "6"
  }
}

output "sg_id" {
  value       = aws_security_group.day6_sg.id
  description = "Security group ID"
}

resource "aws_security_group" "day6_sg2" {
  name        = "day6-sg2"
  description = "Second SG for locking test"

  tags = {
    Name = "day6-sg2"
  }
}
