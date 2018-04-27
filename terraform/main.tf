provider "vsphere" {
  version         = "~> 1.4"
  user            = "${var.vsphere-user}"
  password        = "${var.vsphere-password}"
  vsphere_server  = "${var.vsphere-server}"
  ## Use self-signed certificate.
  allow_unverified_ssl = true
}

## The datacenter has been created manually, probably based on physical location.
data "vsphere_datacenter" "dc-test" {
  name = "datacenter1"
}

## The existing host in the datacenter.
data "vsphere_host" "host-test" {
  name = "esxi.fibernetcpe"
  datacenter_id = "${data.vsphere_datacenter.dc-test.id}"
}
output "host-test-id" {
  value = "${data.vsphere_host.host-test.id}"
}

## Cannot do this, the NIC is already in use:
# resource "vsphere_host_virtual_switch" "switch-test" {
#   name = "switch-test"
#   host_system_id = "${data.vsphere_host.host-test.id}"
#   network_adapters = ["vmnic0"]
#   active_nics  = ["vmnic0"]
#   standby_nics = []
# }



# data "vsphere_resource_pool" "pool" {
#   # Default pool is named $host/Resources.
#   name = "192.168.1.22/Resources"
#   datacenter_id = "${data.vsphere_datacenter.dc.id}"
# }
# data "vsphere_datastore" "ds1" {
#   name = "${var.vsphere-datastore-1}"
#   datacenter_id = "${data.vsphere_datacenter.dc.id}"
# }
# data "vsphere_network" "network-default" {
#   name = "VM Network"
#   datacenter_id = "${data.vsphere_datacenter.dc.id}"
# }

# output "datacenter-swarm-folder-id" {
#   value = "${vsphere_folder.swarm.id}"
# }
# output "pool" {
#   value = "${data.vsphere_resource_pool.pool.id}"
# }
# output "datastore-1" {
#   value = "${data.vsphere_datastore.ds1.id}"
# }
# output "host" {
#   value = "${data.vsphere_host.host.id}"
# }
# output "network-default" {
#   value = "${data.vsphere_network.network-default.id}"
# }
