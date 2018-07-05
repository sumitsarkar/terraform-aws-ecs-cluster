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
  default     = "ami-c91624b0"
  description = "AMI ID. Should be available in the specific region."
}

variable "instance_type" {
  description = "Type of the instance for the cluster."
}

variable "ssh_key_name" {
  description = "SSH Key name. It must exist in the VPC and region."
}

variable "root_block_size" {
  default     = "40"
  description = "Size of the disk attached to the EC2 instances in the cluster."
}

variable "desired_size" {
  default     = 2
  description = "Desired size of the cluster."
}

variable "min_size" {
  default     = 1
  description = "Minimum size of the cluster."
}

variable "max_size" {
  default     = 3
  description = "Maximum size of the cluster."
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
