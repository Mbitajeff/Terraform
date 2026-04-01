# terraform-aws-webserver-cluster

This module deploys a fully load-balanced, auto-scaling web server cluster on AWS. It creates all necessary resources including security groups, a launch template, an Application Load Balancer, a target group with health checks, and an Auto Scaling Group.

## Usage
```hcl
module "webserver_cluster" {
  source = "github.com/Mbitajeff/Terraform//day8/modules/services/webserver-cluster?ref=v0.0.2"

  cluster_name  = "webservers-dev"
  vpc_id        = "vpc-xxxxxxxx"
  subnet_ids    = ["subnet-xxxxxxxx", "subnet-yyyyyyyy"]
  ami_id        = "ami-xxxxxxxx"
  min_size      = 2
  max_size      = 4
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| cluster_name | Name prefix for all resources | string | — | yes |
| vpc_id | VPC ID to deploy into | string | — | yes |
| subnet_ids | List of subnet IDs (min 2, different AZs) | list(string) | — | yes |
| ami_id | AMI ID for EC2 instances | string | — | yes |
| min_size | Minimum number of ASG instances | number | — | yes |
| max_size | Maximum number of ASG instances | number | — | yes |
| instance_type | EC2 instance type | string | t2.micro | no |
| server_port | Port the web server listens on | number | 8080 | no |
| enable_https | Whether to enable HTTPS on port 443 | bool | false | no |

## Outputs

| Name | Description |
|------|-------------|
| alb_dns_name | DNS name of the load balancer |
| asg_name | Name of the Auto Scaling Group |
| alb_security_group_id | ID of the ALB security group |
| target_group_arn | ARN of the target group (v0.0.2+) |

## Versions

- **v0.0.1** — Initial release with core webserver cluster resources
- **v0.0.2** — Added `enable_https` variable and `target_group_arn` output

## Known Limitations

- Requires at least 2 subnets in different Availability Zones for the ALB
- Uses Amazon Linux 2 AMI — user_data script uses `yum` package manager
- HTTP only by default — set `enable_https = true` for HTTPS support
- State is stored locally unless a backend is configured in the calling configuration
