module "external_alb" {
  source                    = "git::https://github.com/terraform-aws-modules/terraform-aws-alb?ref=v3.4.0"
  load_balancer_name        = "${var.external_alb_name}"
  security_groups           = ["${aws_security_group.alb_security_group.id}"]
  log_bucket_name           = "${aws_s3_bucket.log_bucket.bucket}"
  log_location_prefix       = "external-alb"
  load_balancer_is_internal = "false"
  subnets                   = "${var.public_subnet_ids}"
  tags                      = "${map("environment", "${var.environment}", "stack", "${var.stack_name}")}"
  vpc_id                    = "${var.vpc_id}"
  https_listeners           = "${list(map("certificate_arn", var.certificate_arn, "port", 443))}"
  https_listeners_count     = "1"
  http_tcp_listeners        = "${list(map("port", "80", "protocol", "HTTP"))}"
  http_tcp_listeners_count  = "1"
  target_groups             = "${list(map("name", var.external_default_tg, "backend_protocol", "HTTP", "backend_port", "80"))}"
  target_groups_defaults    = "${map("deregistration_delay", "300", "target_type", "instance", "health_check_interval", "30", "health_check_path", "/", "health_check_port", "80", "health_check_healthy_threshold", "5", "health_check_unhealthy_threshold", "5", "health_check_timeout", "5", "backend_protocol", "HTTP", "health_check_matcher", "200-299", "cookie_duration", "300", "stickiness_enabled", "false")}"
  target_groups_count       = "1"
}

resource "aws_route53_record" "external_record_set" {
  count   = "${var.external_route53_enabled == "true"? 1 : 0}"
  name    = "${var.external_route53_record}"
  type    = "A"
  zone_id = "${var.external_alb_zone_id}"

  alias {
    name                   = "${module.external_alb.dns_name}"
    zone_id                = "${data.aws_elb_hosted_zone_id.main.id}"
    evaluate_target_health = true
  }
}
