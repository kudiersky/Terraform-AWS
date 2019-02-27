resource "aws_network_interface" "ec2_eni" {
  count             = "${var.eni_count}"
  subnet_id         = "${element(aws_instance.ec2.*.subnet_id, count.index)}"
  private_ips_count = "${var.private_ips_count}"
  security_groups   = ["${aws_instance.ec2.0.vpc_security_group_ids}"]

  attachment {
    instance     = "${element(aws_instance.ec2.*.id, count.index)}"
    device_index = "1"
  }

  tags {
    Name            = "AWSB${upper(substr(var.tags["vpc"], 0, 1))}${var.tags["os"] == "linux" ? "L" : "W"}${var.tags["name"]}${element(var.az, count.index)}0${count.index+1}"
    application     = "${var.tags["application"]}"
    role            = "${var.tags["role"]}"
    environment     = "${var.tags["environment"]}"
  }
}
