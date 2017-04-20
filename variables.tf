#AWS region
variable "region" {
  description = "AWS region"
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

