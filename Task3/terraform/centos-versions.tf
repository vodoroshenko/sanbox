# CentOS Linux AMI with Terraform

# CentOS 9
data "aws_ami" "centos-9" {
owners      = ["125523088429"]
most_recent = true

  filter {
      name   = "name"
      values = ["CentOS Stream 9*"]
  }

  filter {
      name   = "architecture"
      values = ["x86_64"]
  }

  filter {
      name   = "root-device-type"
      values = ["ebs"]
  }
}
