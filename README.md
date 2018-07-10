# Terraform Module for AWS ECS

This module extends another [module](https://github.com/sumitsarkar/terraform-aws-ecs-cluster-multi-instance) and provides extra functionality of creating both an internal and external load balancers. One can associate Route53 records for the load balancers.

This module also adds Sumologic as a logging driver.