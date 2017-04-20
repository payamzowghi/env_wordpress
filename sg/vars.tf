variable "name" {
  description = "The name of the SG."
}

variable "vpc_id" {
  description = "The VPC_id."
}

output "wp_sg_instance_id" { 
  value = "${aws_security_group.wp_instance.id}"
}

output "wp_sg_db_id" { 
  value = "${aws_security_group.wp_db.id}"
}

output "wp_sg_elb_id" { 
  value = "${aws_security_group.wp_elb.id}"
}

output "wp_sg_efs_id" { 
  value = "${aws_security_group.wp_efs.id}"
}







