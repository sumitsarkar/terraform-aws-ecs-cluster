variable "region" {
  default = "eu-west-1"
}

variable "vpc_id" {
  description = "ID of the VPC in owhich the cluster needs to be launched in."
}

variable "private_subnet_ids" {
  type = "list"
}

variable "public_subnet_ids" {
  type = "list"
}

variable "stack_name" {
  description = "Name of the stack."
}

# Used for tags mostly
variable "environment" {
  description = "Environment name."
}

variable "ami_id" {
  default     = "ami-0b8e62ddc09226d0a"
  description = "AMI ID. Should be available in the specific region."
}

variable "instance_types" {
  type        = "list"
  description = "Type of the instance for the cluster."
}

variable "ssh_key_name" {
  description = "SSH Key name. It must exist in the VPC and region."
}

variable "root_block_device_type" {
  type        = "list"
  description = "Type of the disk attached to the EC2 instances in the cluster.Can be gp2, io, standard"
}

variable "root_block_size" {
  type        = "list"
  description = "Size of the disk attached to the EC2 instances in the cluster."
}

## Scaling Configurations
variable "desired_size" {
  type        = "list"
  description = "Desired size of the cluster."
}

variable "min_size" {
  type        = "list"
  description = "Minimum size of the cluster."
}

variable "max_size" {
  type        = "list"
  description = "Maximum size of the cluster."
}

variable "spot_enabled" {
  default = "false"
  type = "string"
  description = "Adds the spot-enabled tag to the ASG of the instances."
}

variable "enable_newrelic" {
  default = "false"
  type = "string"
  description = "Enabled New Relic Infrastructure monitoring. WARNING: This supports Amazon Linux 2 only"
}

variable "newrelic_key" {
  default = ""
  type = "string"
  description = "New Relic License key to enable monitoring. WARNING: This supports Amazon Linux 2 only"
}

variable "scale_up_cooldown_seconds" {
  type        = "list"
  description = "List for Number of seconds before allowing another scale up activity"
}

variable "scale_down_cooldown_seconds" {
  type        = "list"
  description = "List for Number of seconds before allowing another scale down activity"
}

variable "high_cpu_evaluation_periods" {
  type        = "list"
  description = "List for Number of evaluation periods for high CPU alarm"
}

variable "high_cpu_period_seconds" {
  type        = "list"
  description = "List for Number of seconds in an evaluation period for high CPU alarm"
}

variable "high_cpu_threshold_percent" {
  type        = "list"
  description = "Threshold as a percentage for high CPU alarm"
}

variable "low_cpu_evaluation_periods" {
  type        = "list"
  description = "List for Number of evaluation periods for low CPU alarm "
}

variable "low_cpu_period_seconds" {
  type        = "list"
  description = "List for Number of seconds in an evaluation period for low CPU alarm"
}

variable "low_cpu_threshold_percent" {
  type        = "list"
  description = "List for Threshold as a percentage for low CPU alarm"
}

variable "high_memory_evaluation_periods" {
  type        = "list"
  description = "List for Number of evaluation periods for high memory alarm"
}

variable "high_memory_period_seconds" {
  type        = "list"
  description = "List for Number of seconds in an evaluation period for high memory alarm"
}

variable "high_memory_threshold_percent" {
  type        = "list"
  description = "List for Threshold as a percentage for high memory alarm"
}

variable "low_memory_evaluation_periods" {
  type        = "list"
  description = "List for Number of evaluation periods for low memory alarm"
}

variable "low_memory_period_seconds" {
  type        = "list"
  description = "List for Number of seconds in an evaluation period for low memory alarm"
}

variable "low_memory_threshold_percent" {
  type        = "list"
  description = "List for Threshold as a percentage for low memory alarm"
}

# ALB Configurations
variable "alb_log_bucket" {
  description = "Name of the bucket for ALB logs."
}

## External ALB Configurations
variable "external_alb_name" {
  description = "Name to assign to the External ALB."
}

variable "certificate_arn" {
  description = "ARN of the HTTPS certificate available in the AWS ACM."
}

variable "external_default_tg" {
  description = "Name of the default target group for External ALB"
}

variable "external_route53_enabled" {
  description = "Boolean value to state if you'd like to associate a Route53 record to the ALB."
}

variable "external_route53_record" {
  description = "Entry for the Route53 record for external ALB."
}

variable "external_alb_zone_id" {
  description = "Route53 Zone ID for the External Route53 Record."
}

## Internal ALB Configurations
variable "internal_alb_name" {
  description = "Name to assign to the Internal ALB."
}

variable "internal_default_tg" {
  description = "Name of the default target group for Internal ALB"
}

variable "internal_route53_enabled" {
  description = "Boolean value to state if you'd like to associate a Route53 record to the internal ALB."
}

variable "internal_route53_record" {
  description = "Entry for the Route53 record for external ALB."
}

variable "internal_alb_zone_id" {
  description = "Route53 Zone ID for the Internal Route53 Record."
}
