variable "name" {
  description = "The name of the elb"
}

variable "security_groups" {
  description = "The security groups of elb"
  type       = "list"
  default     = []
}

variable "subnets" {
  description = "The public subnets"
  type       = "list"
  default     = []
}

output "wp_elb_name" {
  value = "${aws_elb.wp.name}"
}

output "wp_elb_dns_address" {
  value = "${aws_elb.wp.dns_name}"
}

