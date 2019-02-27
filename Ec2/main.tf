resource "aws_instance" "ec2" {
  count                  = "${var.instance_count}"
  ami                    = "${var.ami}"
  vpc_security_group_ids = ["${var.security_group_ids}"]
  key_name               = "${var.key_name}"
  instance_type          = "${var.instance_type}"
  iam_instance_profile   = "${aws_iam_instance_profile.ec2_profile.name}"
  subnet_id              = "${element( var.subnet_ids, count.index )}"
  monitoring             = "${var.monitoring}"
  source_dest_check      = "${var.source_dest_check}"
  user_data              = "${var.tags["os"] == "linux" ? data.template_file.linux_user_data.*.rendered[count.index] : data.template_file.windows_user_data.*.rendered[count.index]}"
  private_ip             = "${element( var.private_ips, count.index )}"

  root_block_device {
    volume_size = "${var.root_volume_size}"
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = ["user_data"]
  }

  tags {
    Name            = "AWSB${upper(substr(var.tags["vpc"], 0, 1))}${var.tags["os"] == "linux" ? "L" : "W"}${var.tags["name"]}${element(var.az, count.index)}0${count.index+1}"
    application     = "${var.tags["application"]}"
    role            = "${var.tags["role"]}"
    environment     = "${var.tags["environment"]}"
    os               = "linux|windows"
  }
}
