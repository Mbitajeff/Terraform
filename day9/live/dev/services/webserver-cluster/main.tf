provider "aws" {
  region = "us-east-1"
}

module "webserver_cluster" {
  source = "github.com/Mbitajeff/Terraform//day8/modules/services/webserver-cluster?ref=v0.0.2"

  cluster_name  = "webservers-dev"
  vpc_id        = "vpc-050d7a0017ba4cccc"
  subnet_ids    = ["subnet-085ee38907f4c6d84", "subnet-0e7192648a1091460"]
  ami_id        = "ami-05024c2628f651b80"
  instance_type = "t2.micro"
  min_size      = 2
  max_size      = 4
  server_port   = 8080
  enable_https  = false
}

output "alb_dns_name" {
  value = module.webserver_cluster.alb_dns_name
}

output "target_group_arn" {
  value = module.webserver_cluster.target_group_arn
}
