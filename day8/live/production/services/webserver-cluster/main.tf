provider "aws" {
  region = "us-east-1"
}

module "webserver_cluster" {
  source = "../../../../modules/services/webserver-cluster"

  cluster_name  = "webservers-production"
  vpc_id        = "vpc-050d7a0017ba4cccc"
  subnet_ids    = ["subnet-085ee38907f4c6d84", "subnet-0e7192648a1091460"]
  ami_id        = "ami-05024c2628f651b80"
  instance_type = "t2.medium"
  min_size      = 4
  max_size      = 10
  server_port   = 8080
}

output "alb_dns_name" {
  value       = module.webserver_cluster.alb_dns_name
  description = "The ALB DNS name for production"
}

output "asg_name" {
  value       = module.webserver_cluster.asg_name
  description = "The ASG name for production"
}
