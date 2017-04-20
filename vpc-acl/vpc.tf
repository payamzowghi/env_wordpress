#aws_vpc resource
resource "aws_vpc" "vpc_wp" {
  cidr_block           = "${var.cidr}"
  enable_dns_hostnames = "${var.enable_dns_hostnames}"
  enable_dns_support   = "${var.enable_dns_support}"

  tags {
    Name = "${var.name}-vpc"
  }
}

#The aws_internet_gateway resource 
resource "aws_internet_gateway" "ig_wp" {
  vpc_id = "${aws_vpc.vpc_wp.id}"

  tags {
    Name = "${var.name}-igw"
  }
}

#The aws_route_table_association_public1
resource "aws_route_table_association" "rt_association_public_wp1" {
  subnet_id      = "${aws_subnet.public_wp1.id}"
  route_table_id = "${aws_route_table.rt_public_wp.id}"
}

#The aws_route_table_association_public2
resource "aws_route_table_association" "rt_association_public_wp2" {
  subnet_id      = "${aws_subnet.public_wp2.id}"
  route_table_id = "${aws_route_table.rt_public_wp.id}"
}

#The aws_route_table_association_db1
resource "aws_route_table_association" "rt_association_db_wp1" {
  subnet_id      = "${aws_subnet.DB_wp1.id}"
  route_table_id = "${aws_route_table.rt_db_wp.id}"
}

#The aws_route_table_association_db2
resource "aws_route_table_association" "rt_association_db_wp2" {
  subnet_id      = "${aws_subnet.DB_wp2.id}"
  route_table_id = "${aws_route_table.rt_db_wp.id}"
}

#The aws_route_table_public
resource "aws_route_table" "rt_public_wp" {
  vpc_id = "${aws_vpc.vpc_wp.id}"
  propagating_vgws = ["${var.propagating_vgws}"]

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.ig_wp.id}"
  }

  tags {
    Name = "${var.name}-rt"
  }
}

#The aws_route_table_db
resource "aws_route_table" "rt_db_wp" {
  vpc_id = "${aws_vpc.vpc_wp.id}"

  tags {
    Name = "${var.name}-rt-db"
  }
}

#create and add public subnet in AZ_us_west_2a
resource "aws_subnet" "public_wp1" {
  vpc_id                  = "${aws_vpc.vpc_wp.id}"
  availability_zone       = "us-west-2a"
  cidr_block              = "172.16.2.0/24" 
  map_public_ip_on_launch = true

  tags {
    Name = "${var.name}-public1"
  }
}

#create and add public subnet in AZ_us_west_2b
resource "aws_subnet" "public_wp2" {
  vpc_id                  = "${aws_vpc.vpc_wp.id}"
  availability_zone       = "us-west-2b"
  cidr_block              = "172.16.3.0/24"
  map_public_ip_on_launch = true  
  
  tags {
    Name = "${var.name}-public2"
  }
}

#create and add private subnet_db in AZ_us_west_2a
resource "aws_subnet" "DB_wp1" {
  vpc_id                  = "${aws_vpc.vpc_wp.id}"
  availability_zone       = "us-west-2a"
  cidr_block              = "172.16.4.0/24" 

  tags {
    Name = "${var.name}-db1"
  }
}

#create and add private subnet_db in AZ_us_west_2b
resource "aws_subnet" "DB_wp2" {
  vpc_id            = "${aws_vpc.vpc_wp.id}"
  availability_zone = "us-west-2b"
  cidr_block        = "172.16.5.0/24"

  tags {
    Name = "${var.name}-db2"
  }
}

