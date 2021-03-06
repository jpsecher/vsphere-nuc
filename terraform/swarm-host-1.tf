data "vsphere_virtual_machine" "base" {
  name = "ubuntu-1604-server-base-v1"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

resource "vsphere_virtual_machine" "swarm-host-1" {
  name = "swarm-host-1"
  resource_pool_id = "${data.vsphere_resource_pool.pool.id}"
  datastore_id = "${data.vsphere_datastore.datastore-1.id}"
  num_cpus = 2
  memory   = 8192
  guest_id = "ubuntu64Guest"
  #run_tools_scripts_after_power_on = false
  #run_tools_scripts_after_resume = false
  #run_tools_scripts_before_guest_shutdown = false
  #run_tools_scripts_before_guest_standby = false
  disk {
    label = "disk0"
    size = 40
    disk_mode = "nonpersistent"
  }
  # disk {
  #   label = "disk1"
  #   attach = true
  #   datastore_id = "${data.vsphere_datastore.ds1.id}"
  #   #unit_number = 1
  # }
  network_interface {
    network_id   = "${data.vsphere_network.network.id}"
  }
  clone {
    template_uuid = "${data.vsphere_virtual_machine.base.id}"
  }
}
