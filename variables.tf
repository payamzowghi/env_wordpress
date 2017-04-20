#AWS region
variable "region" {
  description = "AWS region"
}

#VPN IP prefixes
variable "ip_prefixes" {
  description = "Range the customer's LAN IP address"
}


#VPN IP address customer gateway
variable "ip_customer_gateway" {
  description = "Ip address customer gateway"
}

#pair-key
variable "key_name" {
  description = "AWS_key_pair"
  default     = "wordpress_key"
}

#instance type
variable "instance_type" {
  description = "Instance type"
  default     = "t2.micro"
}

