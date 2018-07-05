provider "aws" {
  region = "${var.region}"
}

data "aws_caller_identity" "current" {}
data "aws_elb_service_account" "main" {}

resource "random_id" "server" {
  byte_length = 3
}

data "template_file" "container_instance_cloud_config" {
  template = "${file("${path.module}/cloud-config/ecs_cluster_init.cfg")}"

  vars {
    aws_region  = "${var.region}"
    stack_name  = "${var.stack_name}"
    ecs_cluster = "ecs${title(var.stack_name)}Cluster"
  }
}

data "template_file" "instance_role_policy" {
  template = "${file("${path.module}/roles/instance_role_policy.tpl")}"

  vars {
    account_id              = "${data.aws_caller_identity.current.account_id}"
    region                  = "${var.region}"
    stack_name              = "${var.stack_name}"
    instance_log_group_name = "${var.stack_name}"
    ecs_cluster             = "ecs${title(var.stack_name)}Cluster"
  }
}

module "container_service_cluster" {
  source = "git::https://github.com/azavea/terraform-aws-ecs-cluster?ref=1.1.0"

  vpc_id               = "${var.vpc_id}"
  ami_id               = "${var.ami_id}"
  instance_type        = "${var.instance_type}"
  key_name             = "${var.ssh_key_name}"
  cloud_config_content = "${data.template_file.container_instance_cloud_config.rendered}"

  root_block_device_type = "gp2"
  root_block_device_size = "${var.root_block_size}"

  health_check_grace_period = "300"
  desired_capacity          = "${var.desired_size}"
  min_size                  = "${var.min_size}"
  max_size                  = "${var.max_size}"

  enabled_metrics = [
    "GroupMinSize",
    "GroupMaxSize",
    "GroupDesiredCapacity",
    "GroupInServiceInstances",
    "GroupPendingInstances",
    "GroupStandbyInstances",
    "GroupTerminatingInstances",
    "GroupTotalInstances",
  ]

  private_subnet_ids = "${var.private_subnet_ids}"

  project     = "Backbone"
  environment = "${var.stack_name}"
}

## AWS cloud watch log group
resource "aws_cloudwatch_log_group" "cluster_log_group" {
  name              = "${var.stack_name}"
  retention_in_days = 7

  tags {
    "environment" = "${var.environment}"
    "stack-type"  = "ecs-cluster"
    "stack-name"  = "${var.stack_name}"
  }
}

resource "aws_iam_role_policy" "ecs_create_logs_policy" {
  policy = "${data.template_file.instance_role_policy.rendered}"
  role   = "${module.container_service_cluster.container_instance_ecs_for_ec2_service_role_name}"
}

# EC2 to Internet
resource "aws_security_group_rule" "ec2_to_internet_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 65535
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${module.container_service_cluster.container_instance_security_group_id}"
}
