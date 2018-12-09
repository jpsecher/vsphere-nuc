data "vsphere_datacenter" "dc" {
  name = "${var.vsphere-datacenter}"
}
output "datacenter-id" {
  value = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_host" "host" {
  name = "${var.vsphere-host}"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}
output "host-id" {
  value = "${data.vsphere_host.host.id}"
}

## Cannot do this, the NIC is already in use:
# resource "vsphere_host_virtual_switch" "switch-test" {
#   name = "switch-test"
#   host_system_id = "${data.vsphere_host.host.id}"
#   network_adapters = ["vmnic0"]
#   active_nics  = ["vmnic0"]
#   standby_nics = []
# }

data "vsphere_resource_pool" "pool" {
  # Default pool is named Resources.
  name = "Resources"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}
output "pool-id" {
  value = "${data.vsphere_resource_pool.pool.id}"
}

data "vsphere_datastore" "datastore-1" {
  name = "${var.vsphere-datastores[0]}"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}
data "vsphere_datastore" "datastore-2" {
  name = "${var.vsphere-datastores[1]}"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}
output "datastore-ids" {
  value = ["${data.vsphere_datastore.datastore-1.id}", "${data.vsphere_datastore.datastore-2.id}"]
}

# resource "vsphere_datastore_cluster" "datastore-cluster" {
#   name = "datastore-cluster"
#   datacenter_id = "${data.vsphere_datacenter.dc.id}"
#   sdrs_enabled  = false
# }
# output "datastore-cluster-id" {
#   value = "${vsphere_datastore_cluster.datastore-cluster.id}"
# }

data "vsphere_network" "network" {
  name = "${var.vsphere-network}"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}
output "network-id" {
  value = "${data.vsphere_network.network.id}"
}

provider "vsphere" {
  version = "~> 1.9"
  user = "${var.vsphere-user}"
  password = "${var.vsphere-password}"
  vsphere_server = "${var.vsphere-vcenter}"
  ## Use self-signed certificate.
  allow_unverified_ssl = true
}
