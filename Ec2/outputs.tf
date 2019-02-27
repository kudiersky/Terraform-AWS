output "id" {
  value = "${aws_instance.ec2.*.id}"
}

output "private_ip" {
  value = "${aws_instance.ec2.*.private_ip}"
}

output "eni_private_ip" {
  value = "${aws_network_interface.ec2_eni.*.private_ips}"
}

output "instance_profile_id" {
  value = "${aws_iam_instance_profile.ec2_profile.*.id}"
}

output "role_id" {
  value = "${aws_iam_role.ec2_role.id}"
}
