data "git-commit" "cwd-head" {}
data "amazon-ami" "source-ami" {
  access_key = var.access_key
  secret_key = var.secret_key
  token      = var.token

  filters = {
    virtualization_type = "hvm"
    name                = "*Ubuntu 22.04 LTS*"
    root-device-type    = "ebs"
    architecture        = "arm64"
  }

  owners      = ["amazon"]
  most_recent = true
  region      = "us-east-1"
}

locals {
  instance_type = "" #var.instance_type
  ami_name      = ""
  communicator  = "" #var.communicator
  time_stamp    = formatdate("YYYY-MM-DD--hh-mm-ss", time_stamp())
  truncated_sha = substr(data.git-commit.cwd-head.hash, 0, 8)
  author        = data.git-commit.cwd-head.author
  release       = "${subst(local.time_stamp, 2, 2)}"
}

source "amazon-ebs" "this" {
  access_key    = var.access_key
  secret_key    = var.secret_key
  token         = var.session_token
  source_ami    = data.amazon-ami.source_ami.id
  instance_type = t2.micro
  region        = var.region
  ami_name      = "temp-name"
}
