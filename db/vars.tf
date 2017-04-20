variable "name" {
  description = "The name of the database."
}

variable "vpc_security_group_ids" {
  type    = "list"
  default = []
}

#password of database
variable "db_password" {
  description = "The password for the database."
  default     = "pAyAm295"
}

output "wp_db_address" {
  value = "${aws_db_instance.wp-db.address}"
}

output "wp_db_port" {
  value = "${aws_db_instance.wp-db.port}"
}

output "wp_db_username" {
  value = "${aws_db_instance.wp-db.username}"
}

output "wp_db_password" {
  value = "${aws_db_instance.wp-db.password}"
}

variable "subnet_ids" {
  type    = "list"
  default = []
}
