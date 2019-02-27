data "template_file" "linux_user_data" {
  count    = "${var.instance_count}"
  template = "${var.linux_user_data_template_file}"

  vars {
    password = "${data.aws_ssm_parameter.password.value}"
    hostname = "AWSB${upper(substr(var.tags["vpc"], 0, 1))}${var.tags["os"] == "linux" ? "L" : "W"}${var.tags["name"]}${element(var.az, count.index)}0${count.index+1}"
  }
}

data "template_file" "windows_user_data" {
  count    = "${var.instance_count}"
  template = "${var.windows_user_data_template_file}"

  vars {
    password            = "${data.aws_ssm_parameter.password.value}"
    hostname            = "AWSB${upper(substr(var.tags["vpc"], 0, 1))}${var.tags["os"] == "linux" ? "L" : "W"}${var.tags["name"]}${element(var.az, count.index)}0${count.index+1}"
    domain_netbios_name = "${data.aws_ssm_parameter.domain_netbios_name.value}"
    domain              = "${data.aws_ssm_parameter.domain.value}"
    username            = "${data.aws_ssm_parameter.username.value}"
    ad_password         = "${data.aws_ssm_parameter.ad_password.value}"
  }
}

data "aws_ssm_parameter" "password" {
  name = 
}

data "aws_ssm_parameter" "domain_netbios_name" {
  name = 
}

data "aws_ssm_parameter" "domain" {
  name = 

data "aws_ssm_parameter" "username" {
  name = 
}

data "aws_ssm_parameter" "ad_password" {
  name = 
}
