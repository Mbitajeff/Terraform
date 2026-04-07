resource "aws_autoscaling_group" "example" {
  name_prefix = "${var.cluster_name}-"

  vpc_zone_identifier      = data.aws_subnets.default.ids
  target_group_arns        = [aws_lb_target_group.asg.arn]
  health_check_type        = "ELB"
  health_check_grace_period = 300

  min_size = var.min_size
  max_size = var.max_size

  launch_template {
    id      = aws_launch_template.example.id
    version = "$Latest"
  }

  lifecycle {
    create_before_destroy = true
  }

  tag {
    key                 = "Name"
    value               = var.cluster_name
    propagate_at_launch = true
  }
}
