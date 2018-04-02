resource "aws_security_group" "allow_all" {
  name_prefix = "${var.appname}"
  description = "Allow all"
  vpc_id      = "${var.vpc}"

  egress = {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress = {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "allow_outgoing" {
  name_prefix = "${var.appname}"
  description = "Allow outgoing"
  vpc_id      = "${var.vpc}"

  egress = {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "allow_cluster" {
  name_prefix = "${var.appname}"
  description = "Allow all inside the cluster"
  vpc_id      = "${var.vpc}"

  ingress = {
    from_port = 0
    to_port   = 65535
    protocol  = "tcp"
    self      = true
  }

  egress = {
    from_port = 0
    to_port   = 65535
    protocol  = "tcp"
    self      = true
  }
}

resource "aws_security_group" "allow_ssh" {
  name_prefix = "${var.appname}"
  description = "Allow SSH"
  vpc_id      = "${var.vpc}"

  ingress = {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
