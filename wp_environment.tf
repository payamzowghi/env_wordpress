#use AWS as provider
provider "aws" {
  region = "${var.region}"
}

module "vpc-acl" {
  source           = "./vpc-acl"
  name             = "wp"
  cidr             = "172.16.0.0/16"
  propagating_vgws = ["${aws_vpn_gateway.wp.id}"]
}

module "sg" {
  source         = "./sg"
  name           = "wp"
  vpc_id         = "${module.vpc-acl.wp_vpc_id}"
}

module "elb" {
  source          = "./elb"
  name            = "wp"  
  subnets         = ["${module.vpc-acl.wp_subnet_public1_id}", "${module.vpc-acl.wp_subnet_public2_id}"]
  security_groups = ["${module.sg.wp_sg_elb_id}"]
}

module "db"  {
  source                 = "./db"
  name                   = "wp"  
  subnet_ids             = ["${module.vpc-acl.wp_subnet_db1_id}", "${module.vpc-acl.wp_subnet_db2_id}"]
  vpc_security_group_ids = ["${module.sg.wp_sg_db_id}"]
}


#create_cluster and run user_data after boot EC2
resource "aws_launch_configuration" "wp" {
  name_prefix                 = "wp_launch"
  image_id                    = "ami-a58d0dc5"
  instance_type               = "${var.instance_type}"
  key_name                    = "${var.key_name}"
  security_groups             = ["${module.sg.wp_sg_instance_id}"]
  associate_public_ip_address = true
  iam_instance_profile        = "assignments"
  user_data                   = "${data.template_file.user_data.rendered}"  

lifecycle {
   create_before_destroy = true
 }
}

#ASG will run between 2_and 4_EC2 Instances
resource "aws_autoscaling_group" "wp" {
  launch_configuration      = "${aws_launch_configuration.wp.id}"
  load_balancers            = ["${module.elb.wp_elb_name}"]
  name                      = "wp_AutoSG"
  vpc_zone_identifier       = ["${module.vpc-acl.wp_subnet_public1_id}", "${module.vpc-acl.wp_subnet_public2_id}"]
  min_size                  = 2 
  max_size                  = 4 
  desired_capacity          = 2
  health_check_type         = "ELB"
  health_check_grace_period = 600
  force_delete              = true
  tag {
    key                 = "Name"
    value               = "wp_asg"
    propagate_at_launch = true
  }
  lifecycle { 
    create_before_destroy = true
  }
}

#user_data for install wordpress_ubuntu.sh in instances
data "template_file" "user_data" {
  template = "${file("files/wordpress_ubuntu.sh")}"

  vars {
  db_address   = "${module.db.wp_db_address}"
  db_port      = "${module.db.wp_db_port}"
  db_user      = "${module.db.wp_db_username}" 
  db_password  = "${module.db.wp_db_password}" 
 }
}
