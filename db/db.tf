#db_subnet_group
resource "aws_db_subnet_group" "wp_db_subnet_group" {
  name       = "${var.name}-db-subnet_group"
  subnet_ids = ["${var.subnet_ids}"]

  tags {
    Name = "My DB subnet group"
  }
}

#create DB_instance
resource "aws_db_instance" "wp-db" {
  allocated_storage       = 5
  storage_type            = "gp2"
  engine                  = "mysql"
  engine_version          = "5.6.27"
  instance_class          = "db.t2.micro"
  name                    = "mydb"
  username                = "wp_db"
  password                = "${var.db_password}"
  backup_retention_period = "30"
  backup_window           = "08:03-08:33"
  maintenance_window      = "Mon:00:00-Mon:03:00"
  multi_az                = true 
  vpc_security_group_ids  = ["${var.vpc_security_group_ids}"]
  db_subnet_group_name    = "${aws_db_subnet_group.wp_db_subnet_group.id}"
  parameter_group_name    = "default.mysql5.6"
  apply_immediately       = true
 
  tags {
    Name = "${var.name}-DataBase"
  }
}

