resource "aws_cloudwatch_metric_alarm" "cpualarm" {
  alarm_name          = "cpu-high-ecs_cluster"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "80"
  alarm_description   = "This metric monitor EC2 instance cpu utilization"
  alarm_actions       = ["${aws_autoscaling_policy.ecs_cluster-scale-up.arn}"]

  dimensions {
    AutoScalingGroupName = "${aws_autoscaling_group.ecs_cluster.name}"
  }
}

resource "aws_cloudwatch_metric_alarm" "cpualarm-down" {
  alarm_name          = "cpu-low-ecs_cluster"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "20"
  alarm_description   = "This metric monitor EC2 instance cpu utilization"
  alarm_actions       = ["${aws_autoscaling_policy.ecs_cluster-scale-down.arn}"]
  depends_on          = ["aws_cloudwatch_metric_alarm.cpualarm"]

  dimensions {
    AutoScalingGroupName = "${aws_autoscaling_group.ecs_cluster.name}"
  }
}
