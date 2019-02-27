# EC2

variable "instance_count" {}

variable "eni_count" {
  default = 0
}

variable "instance_type" {}

variable "ami" {}

variable "key_name" {}

variable "security_group_ids" {
  type = "list"
}

variable "subnet_ids" {
  type = "list"
}

variable "private_ips" {
  type    = "list"
  default = [""]
}

variable "tags" {
  type = "map"
}

variable "source_dest_check" {
  default = "true"
}

variable "monitoring" {
  default = "false"
}

variable "az" {
  type    = "list"
  default = ["A", "B"]
}

# Root Volume Device

variable "root_volume_size" {
  default = 50
}

# EBS

variable "ebs_count" {
  default = 1
}

variable "ebs_size" {
  type = "list"
}

variable "ebs_type" {
  default = "gp2"
}

variable "device_name" {
  default = "/dev/sdh"
}

variable "ebs_encrypted" {
  default = true
}

# CloudWatch
variable "alarm_memory_high_threshold" {
  default = 80
}

variable "alarm_cpu_high_threshold" {
  default = 80
}

variable "alarm_actions_list" {
  type    = "list"
  default = []
}

# User Data

variable "linux_user_data_template_file" {}

variable "windows_user_data_template_file" {}

# IAM

variable "policy_prefix" {}

## DNS

variable "int_zone_id" {}

# ENI

variable "private_ips_count" {
  default = 1
}
