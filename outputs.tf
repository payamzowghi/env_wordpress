#address of ELB
output "elb_address" {
  value = "${module.elb.wp_elb_dns_address}"
}

