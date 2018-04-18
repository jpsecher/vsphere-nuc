data "vsphere_virtual_machine" "base" {
  name = "ubuntu-1604-server-base-v6"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

output "base-machine-id" {
  value = "${data.vsphere_virtual_machine.base.id}"
}
