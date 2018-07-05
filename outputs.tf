output "cluster_name" {
  value = "${module.container_service_cluster.name}"
}

output "cluster_id" {
  value = "${module.container_service_cluster.id}"
}

output "cluster_instance_security_group_id" {
  value = "${module.container_service_cluster.container_instance_security_group_id}"
}

output "ecs_autoscale_role_name" {
  value = "${module.container_service_cluster.ecs_autoscale_role_name}"
}
output "ecs_autoscale_role_arn" {
  value = "${module.container_service_cluster.ecs_autoscale_role_arn}"
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
