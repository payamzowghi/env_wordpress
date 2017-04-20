resource "aws_efs_file_system" "wp" {
  creation_token = "wordpress"

  tags {
    Name = "efs_wp"
  }
}

resource "aws_efs_mount_target" "wp1" {
  file_system_id  = "${aws_efs_file_system.wp.id}"
  subnet_id       = "${module.vpc-acl.wp_subnet_public1_id}"
  security_groups = ["${module.sg.wp_sg_efs_id}"]

}

resource "aws_efs_mount_target" "wp2" {
  file_system_id  = "${aws_efs_file_system.wp.id}"
  subnet_id       = "${module.vpc-acl.wp_subnet_public2_id}"
  security_groups = ["${module.sg.wp_sg_efs_id}"]

}

