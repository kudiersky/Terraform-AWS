resource "aws_ebs_volume" "ec2_ebs" {
  count             = "${var.instance_count}"
  availability_zone = "${element(aws_instance.ec2.*.availability_zone, count.index)}"
  size              = "${element(var.ebs_size, count.index)}"
  encrypted         = "${var.ebs_encrypted}"
  type              = "${var.ebs_type}"

  tags {
    Name            = "AWSB${upper(substr(var.tags["vpc"], 0, 1))}${var.tags["os"] == "linux" ? "L" : "W"}${var.tags["name"]}${element(var.az, count.index)}0${count.index+1}"
    application     = "${var.tags["application"]}"
    role            = "${var.tags["role"]}"
    environment     = "${var.tags["environment"]}"
  }
}

resource "aws_volume_attachment" "ec2_ebs" {
  count       = "${var.instance_count}"
  device_name = "${var.device_name}"
  volume_id   = "${element(aws_ebs_volume.ec2_ebs.*.id, count.index)}"
  instance_id = "${element(aws_instance.ec2.*.id, count.index)}"
}
