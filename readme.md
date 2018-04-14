# Terraforming VMWare VSphere ESXi

The target machine is an Intel NUC with 32GB RAM and 2 x 256GB SSD disks.

Plan:

* [x] Get contact to VSphere through Terraform.
* [x] Create a virtual disk.
* [ ] Create a virtual machine with the disk attached.
* [ ] Create a cluster that Docker Swarm can run on.
* [ ] Create a Gluster host for persistent storage.
* [ ] Get Docker GetStarted example to run on Gluster-backed storage.
* [ ] Create and deploy a new image with Packer.

## Initial setup

Create a file `terraform/secret.tf` like

    variable "vsphere-password" { default = "my-esxi-root-password" }

## Usage

    $ cd terraform
    $ terraform plan
    $ terraform apply



