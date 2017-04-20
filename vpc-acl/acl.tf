resource "aws_network_acl" "wp_acl_public" {
  vpc_id = "${aws_vpc.vpc_wp.id}"
  subnet_ids = ["${aws_subnet.public_wp1.id}", "${aws_subnet.public_wp2.id}"]  
 
  egress {
    protocol   = -1
    rule_no    = 100 
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  ingress {
    protocol   = -1
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  tags {
    Name = "${var.name}-acl-public"
  }
}

resource "aws_network_acl" "wp_acl_db" {
  vpc_id = "${aws_vpc.vpc_wp.id}"
  subnet_ids = ["${aws_subnet.DB_wp1.id}", "${aws_subnet.DB_wp2.id}"]  
 
  egress {
    protocol   = -1
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  ingress {
    protocol   = -1
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  tags {
    Name = "${var.name}-acl-db"
  }
}
