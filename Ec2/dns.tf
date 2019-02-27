# Route 53 Addresses 

resource "aws_route53_record" "ec2" {
  count   = "${var.instance_count}"
  zone_id = "${var.int_zone_id}"
  name    = "AWSB${upper(substr(var.tags["vpc"], 0, 1))}${var.tags["os"] == "linux" ? "L" : "W"}${var.tags["name"]}${element(var.az, count.index)}0${count.index+1}"
  records = ["${element(aws_instance.ec2.*.private_ip, count.index)}"]
  type    = "A"
  ttl     = "300"
}
