resource "aws_launch_configuration" "ecs_cluster" {
  name                        = "${var.appname}_cluster_conf"
  instance_type               = "${var.instance_type}"
  image_id                    = "${var.ami}"
  iam_instance_profile        = "${aws_iam_instance_profile.ecs.id}"
  associate_public_ip_address = true

  security_groups = [
    "${aws_security_group.allow_ssh.id}",
    "${aws_security_group.allow_outgoing.id}",
    "${aws_security_group.allow_cluster.id}",
  ]

  user_data = "#!/bin/bash\necho ECS_CLUSTER=${var.appname}-ecs > /etc/ecs/ecs.config"
  key_name  = "${var.key_name}"
}

resource "aws_autoscaling_group" "ecs_cluster" {
  name                      = "${var.appname}_ag"
  vpc_zone_identifier       = ["${var.public_subnets}"]
  min_size                  = 2
  max_size                  = 4
  desired_capacity          = 2
  launch_configuration      = "${aws_launch_configuration.ecs_cluster.name}"
  health_check_type         = "EC2"
  health_check_grace_period = 300
}

resource "aws_autoscaling_policy" "ecs_cluster-scale-up" {
  name                   = "ecs_cluster-scale-up"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = "${aws_autoscaling_group.ecs_cluster.name}"
}

resource "aws_autoscaling_policy" "ecs_cluster-scale-down" {
  name                   = "ecs_cluster-scale-down"
  scaling_adjustment     = -1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = "${aws_autoscaling_group.ecs_cluster.name}"
}
