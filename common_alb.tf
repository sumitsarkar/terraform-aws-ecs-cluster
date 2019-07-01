data "aws_elb_hosted_zone_id" "main" {
}

data "aws_iam_policy_document" "bucket_policy" {
  statement {
    sid = "AllowToPutLoadBalancerLogsToS3Bucket"

    actions = [
      "s3:PutObject",
    ]

    resources = [
      "arn:aws:s3:::${var.alb_log_bucket}/*",
    ]

    principals {
      type = "AWS"

      identifiers = [
        "arn:aws:iam::${data.aws_elb_service_account.main.id}:root",
      ]
    }
  }
}

resource "aws_s3_bucket" "log_bucket" {
  bucket        = var.alb_log_bucket
  policy        = data.aws_iam_policy_document.bucket_policy.json
  force_destroy = true

  tags = {
    "environment" = var.environment
    "stack-name"  = var.stack_name
    "stack-type"  = "ecs-cluster-alb-access-logs"
  }

  lifecycle_rule {
    id      = "log-expiration"
    enabled = "true"

    expiration {
      days = "7"
    }
  }
}

# Consul ALB security group. Used for allowing connections at the given ports.
resource "aws_security_group" "alb_security_group" {
  name        = "${var.stack_name}-alb-sg-${random_id.server.hex}"
  description = "ALB Security Group"
  vpc_id      = var.vpc_id

  ingress {
    from_port = 80
    to_port   = 80
    protocol  = "tcp"

    cidr_blocks = [
      "0.0.0.0/0",
    ]
  }

  ingress {
    from_port = 443
    to_port   = 443
    protocol  = "tcp"

    cidr_blocks = [
      "0.0.0.0/0",
    ]
  }

  tags = {
    "stack-type"  = "alb"
    "environment" = var.environment
    "stack-name"  = var.stack_name
  }
}

resource "aws_security_group_rule" "host_to_alb_ingress" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 65535
  protocol                 = "tcp"
  security_group_id        = aws_security_group.alb_security_group.id
  source_security_group_id = module.container_service_cluster.container_instance_security_group_id
}

resource "aws_security_group_rule" "alb_to_host_ingress" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 65535
  protocol                 = "-1"
  security_group_id        = module.container_service_cluster.container_instance_security_group_id
  source_security_group_id = aws_security_group.alb_security_group.id
}

# ALB to Internet
resource "aws_security_group_rule" "alb_to_internet_egress" {
  type      = "egress"
  from_port = 0
  to_port   = 65535
  protocol  = "-1"

  cidr_blocks = [
    "0.0.0.0/0",
  ]

  security_group_id = aws_security_group.alb_security_group.id
}

