resource "vsphere_virtual_disk" "persistent-storage-1" {
  size = 16
  type = "thin"
  vmdk_path = "persistent-1.vmdk"
  datacenter = "${data.vsphere_datacenter.dc.id}"
  datastore = "${var.vsphere-datastore-1}"
}

output "persistent-storage-1-id" {
  value = "${vsphere_virtual_disk.persistent-storage-1.id}"
}
