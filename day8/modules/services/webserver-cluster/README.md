# Webserver Cluster Module

This module deploys a fully load-balanced web server cluster on AWS.

## Resources Created
- ALB Security Group
- Instance Security Group
- Launch Template
- Application Load Balancer
- ALB Listener
- Target Group with health checks
- Auto Scaling Group

## Usage
```hcl
module "webserver_cluster" {
  source = "../../../../../modules/services/webserver-cluster"

  cluster_name  = "webservers-dev"
  vpc_id        = "vpc-xxxxxxxx"
  subnet_ids    = ["subnet-xxxxxxxx", "subnet-yyyyyyyy"]
  ami_id        = "ami-xxxxxxxx"
  instance_type = "t2.micro"
  min_size      = 2
  max_size      = 4
  server_port   = 8080
}
```

## Inputs

| Name | Description | Type | Required |
|------|-------------|------|----------|
| cluster_name | Name prefix for all resources | string | yes |
| vpc_id | VPC ID to deploy into | string | yes |
| subnet_ids | List of subnet IDs | list(string) | yes |
| ami_id | AMI ID for EC2 instances | string | yes |
| min_size | Minimum ASG instances | number | yes |
| max_size | Maximum ASG instances | number | yes |
| instance_type | EC2 instance type | string | no (default: t2.micro) |
| server_port | Web server port | number | no (default: 8080) |

## Outputs

| Name | Description |
|------|-------------|
| alb_dns_name | DNS name of the load balancer |
| asg_name | Name of the Auto Scaling Group |
| alb_security_group_id | ID of the ALB security group |
