data "aws_ami" "blackbox_ami" {
  provider   = "aws.selected_region"
  most_recent = true
  owners = ["self"]

  filter {
    name   = "name"
    values = ["blackbox-cloud/${var.blackbox_version}/*"]
  }
}

data "template_file" "cloud_init" {
  template = "${file("${path.module}/files/cloudinit.yaml")}"
  vars {
    fqdn          = "${local.instance_fqdn}"
    password_hash = "${var.blackbox_password_hash}"
    username      = "${var.os_username}"
  }
}
