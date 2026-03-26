provider "aws" {
  region = var.region
}

# Security Group allowing HTTP in and all out
resource "aws_security_group" "web_sg" {
  name        = "web-sg"
  description = "Allow HTTP inbound"

  ingress {
    from_port   = var.server_port
    to_port     = var.server_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# EC2 instance
resource "aws_instance" "web" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  security_groups        = [aws_security_group.web_sg.name]
  associate_public_ip_address = true

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y httpd
              systemctl start httpd
              systemctl enable httpd
              echo "<h1>Hello from Terraform web server</h1>" > /var/www/html/index.html
              EOF

  tags = {
    Name = "Terraform-Web-Server"
  }
}

# Output the public IP
output "web_instance_public_ip" {
  value = aws_instance.web.public_ip
  description = "Public IP of the web server"
}