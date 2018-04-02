resource "aws_ecs_cluster" "cluster" {
  name = "${var.appname}-ecs"
}

data "template_file" "task_definition" {
  template = "${file("task-definition.json.tmpl")}"

  vars {
    name        = "${var.appname}"
    image       = "${var.dockerimg}"
    docker_port = "${var.docker_port}"
    host_port   = "${var.host_port}"
  }
}

resource "aws_ecs_task_definition" "ecs_task" {
  family                = "${var.appname}"
  container_definitions = "${data.template_file.task_definition.rendered}"
}

resource "aws_ecs_service" "ecs_service" {
  name                               = "${var.appname}-ecs"
  cluster                            = "${aws_ecs_cluster.cluster.id}"
  task_definition                    = "${aws_ecs_task_definition.ecs_task.arn}"
  desired_count                      = 2
  iam_role                           = "${aws_iam_role.ecs_alb.arn}"
  depends_on                         = ["aws_iam_policy_attachment.ecs_alb", "aws_alb.service_alb"]
  deployment_minimum_healthy_percent = 50

  load_balancer {
    target_group_arn = "${element(aws_alb_target_group.alb_targets.*.arn, 0)}"
    container_name   = "${var.appname}"
    container_port   = "${var.docker_port}"
  }
}
