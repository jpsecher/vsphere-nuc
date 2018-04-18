data "vsphere_virtual_machine" "template" {
  name = "ubuntu-1604-server-base-v6"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

output "template-machine-id" {
  value = "${data.vsphere_virtual_machine.template.id}"
}

resource "vsphere_virtual_machine" "swarm-host-2" {
  name = "swarm-host-2"
  resource_pool_id = "${data.vsphere_resource_pool.pool.id}"
  datastore_id = "${data.vsphere_datastore.ds1.id}"

  num_cpus = 2
  memory = 1024
  guest_id = "${data.vsphere_virtual_machine.template.guest_id}"

  scsi_type = "${data.vsphere_virtual_machine.template.scsi_type}"

  network_interface {
    network_id   = "${data.vsphere_network.network-default.id}"
    adapter_type = "${data.vsphere_virtual_machine.template.network_interface_types[0]}"
  }

  disk {
    label = "disk0"
    size = "${data.vsphere_virtual_machine.template.disks.0.size}"
    eagerly_scrub = "${data.vsphere_virtual_machine.template.disks.0.eagerly_scrub}"
    thin_provisioned = "${data.vsphere_virtual_machine.template.disks.0.thin_provisioned}"
  }

  clone {
    template_uuid = "${data.vsphere_virtual_machine.template.id}"
  }
}
