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

provider "vsphere" {
  version         = "~> 1.4"
  user            = "${var.vsphere-user}"
  password        = "${var.vsphere-password}"
  vsphere_server  = "${var.vsphere-vcenter}"
  ## Use self-signed certificate.
  allow_unverified_ssl = true
}
