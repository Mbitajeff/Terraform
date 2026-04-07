resource "aws_launch_template" "example" {
  name_prefix   = "${var.cluster_name}-"
  image_id      = var.ami
  instance_type = var.instance_type

  vpc_security_group_ids = [aws_security_group.instance.id]

  user_data = base64encode(templatefile("${path.module}/user-data.sh", {
    server_port = var.server_port
    version     = var.app_version
  }))

  lifecycle {
    create_before_destroy = true
  }
}
