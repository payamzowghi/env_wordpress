#create aws_elb resource(two availability_zones) and https
resource "aws_elb" "wp" {
  name                 = "${var.name}-elb"
  subnets              = ["${var.subnets}"]
  security_groups      = ["${var.security_groups}"]
  
  listener {
    instance_port      = 80 
    instance_protocol  = "http"
    lb_port            = 80
    lb_protocol        = "http"
  }

  listener {
    instance_port      = 80 
    instance_protocol  = "http"
    lb_port            = 443
    lb_protocol        = "https"
    ssl_certificate_id = "arn:aws:iam::272462672480:server-certificate/elastic-beanstalk-x509"
  }
  
  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 6
    timeout             = 4
    target              = "TCP:80"
    interval            = 80
  }
}
