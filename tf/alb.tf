resource "aws_alb" "service_alb" {
  name    = "${var.appname}-alb"
  subnets = ["${var.public_subnets}"]

  security_groups = [
    "${aws_security_group.allow_cluster.id}",
    "${aws_security_group.allow_all.id}",
  ]
}

resource "aws_alb_target_group" "alb_targets" {
  name     = "${var.appname}-tg"
  port     = "${var.host_port}"
  protocol = "HTTP"
  vpc_id   = "${var.vpc}"

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 10
    path                = "/"
    interval            = 5
    timeout             = 4
  }
}

resource "aws_alb_listener" "alb_listener" {
  load_balancer_arn = "${aws_alb.service_alb.arn}"
  port              = "${var.lb_port}"
  protocol          = "HTTP"

  default_action {
    target_group_arn = "${element(aws_alb_target_group.alb_targets.*.arn, 0)}"
    type             = "forward"
  }
}
