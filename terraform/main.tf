provider "vsphere" {
  version         = "~> 1.4"
  user            = "${var.vsphere-user}"
  password        = "${var.vsphere-password}"
  vsphere_server  = "${var.vsphere-server}"
  allow_unverified_ssl = true
}

data "vsphere_datacenter" "dc" {}
data "vsphere_datastore" "ds1" {
  name = "${var.vsphere-datastore-1}"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}
data "vsphere_datastore" "ds2" {
  name = "${var.vsphere-datastore-2}"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}
data "vsphere_host" "host" {
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}
data "vsphere_resource_pool" "pool" {
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}
data "vsphere_network" "network-default" {
  name = "VM Network"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

output "datacenter" {
  value = "${data.vsphere_datacenter.dc.id}"
}
output "datastore-1" {
  value = "${data.vsphere_datastore.ds1.id}"
}
output "datastore-2" {
  value = "${data.vsphere_datastore.ds2.id}"
}
output "host" {
  value = "${data.vsphere_host.host.id}"
}
output "pool" {
  value = "${data.vsphere_resource_pool.pool.id}"
}
output "network-default" {
  value = "${data.vsphere_network.network-default.id}"
}