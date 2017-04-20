variable "name" {
  description = "The name of the VPC."
}

variable "cidr" {
  description = "The CIDR of the VPC."
}

variable "enable_dns_hostnames" {
  description = "Should be true if you want to use private DNS within the VPC"
  default     = true
}

variable "propagating_vgws" {
  description = "A list of virtual gateways for propagation."
  type        = "list"
}

variable "enable_dns_support" {
  description = "Should be true if you want to use private DNS within the VPC"
  default     = true
}

output "wp_vpc_id" {
  value = "${aws_vpc.vpc_wp.id}"
}

output "wp_subnet_public1_id" {
  value = "${aws_subnet.public_wp1.id}"
}

output "wp_subnet_public2_id" {
  value = "${aws_subnet.public_wp2.id}"
}

output "wp_subnet_db1_id" {
  value = "${aws_subnet.DB_wp1.id}"
}

output "wp_subnet_db2_id" {
  value = "${aws_subnet.DB_wp2.id}"
}









