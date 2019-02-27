## terraform-aws-ec2
```
module "ec2" {
  source = "../modules_v2/ec2"
  instance_count     = ""
  instance_type      = ""
  ami                = ""
  key_name           = ""
  user_data          = ""
  security_group_ids = [""]
  subnet_ids         = [""]
  private_ips        = [""]

  ## EBS

  ebs_size = [""]


  ## DNS
  int_zone_id = ""

  ## User Data
  linux_user_data_template_file   = ""
  windows_user_data_template_file = ""

  ## IAM
  policy_prefix = "TEST"

  tags = {
    name             = "${upper(substr(var.release, 1, 2))}[application]"
    application      = ""
    environment      = ""
    os               = "linux|windows"
  }
}
```
