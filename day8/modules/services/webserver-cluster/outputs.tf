output "alb_dns_name" {
  value       = aws_lb.main.dns_name
  description = "The domain name of the load balancer"
}

output "asg_name" {
  value       = aws_autoscaling_group.main.name
  description = "The name of the Auto Scaling Group"
}

output "alb_security_group_id" {
  value       = aws_security_group.alb.id
  description = "The ID of the ALB security group"
}

output "target_group_arn" {
  value       = aws_lb_target_group.main.arn
  description = "The ARN of the target group"
}

output "autoscaling_enabled" {
  value       = var.enable_autoscaling
  description = "Whether autoscaling policies are enabled"
}
