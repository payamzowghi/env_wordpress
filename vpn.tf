resource "aws_customer_gateway" "wp" {
  bgp_asn    = 65000
  ip_address = "${var.ip_customer_gateway}"
  type       = "ipsec.1"

  tags {
    Name = "wp-cg"
  }
}

resource "aws_vpn_gateway" "wp" {
  tags {
    Name = "wp-vpn-gateway"
  }
}

resource "aws_vpn_gateway_attachment" "wp" {
  vpc_id         = "${module.vpc-acl.wp_vpc_id}"
  vpn_gateway_id = "${aws_vpn_gateway.wp.id}"
}

resource "aws_vpn_connection" "wp" {
  vpn_gateway_id      = "${aws_vpn_gateway.wp.id}"
  customer_gateway_id = "${aws_customer_gateway.wp.id}"
  type                = "ipsec.1"
  static_routes_only  = true

  tags {
    Name = "wp_vpn"
  }
}
resource "aws_vpn_connection_route" "wp" {
  destination_cidr_block = "${var.ip_prefixes}"
  vpn_connection_id      = "${aws_vpn_connection.wp.id}"
}
