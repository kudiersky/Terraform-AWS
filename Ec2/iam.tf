
resource "aws_iam_role_policy" "s3_read_write_policy" {
  name = "${var.policy_prefix}_s3_read_write_policy"
  role = "${aws_iam_role.ec2_role.name}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
            "Sid": "",
            "Effect": "Allow",
            "Action": [
                "s3:PutObject",
                "s3:GetObject"
            ],
            "Resource": "*"
  }
  ]
}
EOF
}

resource "aws_iam_role" "ec2_role" {
  name               = "${var.policy_prefix}EC2role"
  assume_role_policy = "${data.aws_iam_policy_document.assume_role_policy.json}"
}

resource "aws_iam_instance_profile" "ec2_profile" {
  name = "${var.policy_prefix}EC2Profile"
  role = "${aws_iam_role.ec2_role.name}"
}
