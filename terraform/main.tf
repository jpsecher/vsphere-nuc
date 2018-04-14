provider "vsphere" {
  version         = "~> 1.4"
  user            = "root"
  password        = "${var.vsphere-password}"
  vsphere_server  = "esxi"
  allow_unverified_ssl = true
}

data "vsphere_datacenter" "datacenter" {}

output "datacenter" {
  value = "${data.vsphere_datacenter.datacenter.id}"
}
