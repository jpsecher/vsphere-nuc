variable "vsphere-vcenter" {
  default = "vcenter.fibernetcpe"
}
## The datacenter has been created manually, probably based on physical location.
variable "vsphere-datacenter" {
  default = "datacenter1"
}
## The existing host in the datacenter.
variable "vsphere-host" {
  default = "esxi.fibernetcpe"
}
## The physical datastores.
variable "vsphere-datastores" {
  default = [
    "datastore1",
    "datastore2"
  ]
}
variable "vsphere-network" {
  default = "VM Network"
}
variable "vsphere-user" {
  default = "administrator@vsphere.local"
}
