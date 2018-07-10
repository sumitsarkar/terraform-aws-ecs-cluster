output "cluster_name" {
  value = "${module.container_service_cluster.name}"
}

output "cluster_id" {
  value = "${module.container_service_cluster.id}"
}

output "cluster_instance_security_group_id" {
  value = "${module.container_service_cluster.container_instance_security_group_id}"
}

output "ecs_service_role_name" {
  value = "${module.container_service_cluster.ecs_service_role_name}"
}
output "ecs_service_role_arn" {
  value = "${module.container_service_cluster.ecs_service_role_arn}"
}

output "container_instance_autoscaling_group_name" {
  value = "${module.container_service_cluster.container_instance_autoscaling_group_name}"
}

output "internal_alb_id" {
  value = "${module.internal_alb.load_balancer_id}"
}

output "external_alb_id" {
  value = "${module.external_alb.load_balancer_id}"
}

output "internal_load_balancer_arn_suffix" {
  value = "${module.internal_alb.load_balancer_arn_suffix}"
}

output "external_load_balancer_arn_suffix" {
  value = "${module.external_alb.load_balancer_arn_suffix}"
}

output "internal_dns_name" {
  value = "${module.internal_alb.dns_name}"
}

output "external_dns_name" {
  value = "${module.external_alb.dns_name}"
}

output "external_alb_http_tcp_listener_arns" {
  description = "The ARN of the TCP and HTTP load balancer listeners created."
  value       = "${module.external_alb.http_tcp_listener_arns}"
}

output "external_alb_http_tcp_listener_ids" {
  description = "The IDs of the TCP and HTTP load balancer listeners created."
  value       = "${module.external_alb.http_tcp_listener_ids}"
}

output "external_https_listener_arns" {
  description = "The ARNs of the HTTPS load balancer listeners created."
  value       = "${module.external_alb.https_listener_arns}"
}

output "external_https_listener_ids" {
  description = "The IDs of the load balancer listeners created."
  value       = "${module.external_alb.https_listener_ids}"
}

output "internal_alb_http_tcp_listener_arns" {
  description = "The ARN of the TCP and HTTP load balancer listeners created."
  value       = "${module.internal_alb.http_tcp_listener_arns}"
}

output "internal_alb_http_tcp_listener_ids" {
  description = "The IDs of the TCP and HTTP load balancer listeners created."
  value       = "${module.internal_alb.http_tcp_listener_ids}"
}
