module "internal_alb" {
  source                    = "git::https://github.com/terraform-aws-modules/terraform-aws-alb?ref=v4.1.0"
  load_balancer_name        = var.internal_alb_name
  security_groups           = [aws_security_group.alb_security_group.id]
  log_bucket_name           = aws_s3_bucket.log_bucket.bucket
  log_location_prefix       = "internal-alb"
  load_balancer_is_internal = "true"
  subnets                   = var.public_subnet_ids
  tags = {
    "environment" = var.environment
    "stack"       = var.stack_name
  }
  vpc_id = var.vpc_id
  http_tcp_listeners = [
    {
      port     = "80"
      protocol = "HTTP"
    },
  ]
  http_tcp_listeners_count = "1"
  target_groups = [
    {
      name             = var.internal_default_tg
      backend_protocol = "HTTP"
      backend_port     = "80"
    },
  ]
  target_groups_defaults = {
    cookie_duration                  = 86400
    deregistration_delay             = 300
    health_check_interval            = 10
    health_check_healthy_threshold   = 3
    health_check_path                = "/"
    health_check_port                = "traffic-port"
    health_check_timeout             = 5
    health_check_unhealthy_threshold = 3
    health_check_matcher             = "200-299"
    stickiness_enabled               = false
    target_type                      = "instance"
    slow_start                       = 0
  }

  target_groups_count = "1"
}

resource "aws_route53_record" "internal_record_set" {
  count   = var.internal_route53_enabled == "true" ? 1 : 0
  name    = var.internal_route53_record
  type    = "A"
  zone_id = var.internal_alb_zone_id

  alias {
    name                   = module.internal_alb.dns_name
    zone_id                = data.aws_elb_hosted_zone_id.main.id
    evaluate_target_health = true
  }
}

