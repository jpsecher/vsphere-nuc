# Terraforming VMWare VSphere ESXi

The target machine is an Intel NUC with 32GB RAM and 2 x 256GB SSD disks.

Plan:

* [x] Get contact to VSphere through Terraform.
* [x] Create a virtual disk.
* [x] Create and deploy a new image with Packer.
* [ ] Create a virtual machine with the disk attached.
* [ ] Create a cluster that Docker Swarm can run on.
* [ ] Create a Gluster host for persistent storage.
* [ ] Get Docker GetStarted example to run on Gluster-backed storage.
* [ ] Find out the minimal permissions needed by the DevOps user running Packer/Terraform.

## Initial setup

Get the passwords to your ESXi host and your vCenter adminiatration account. Create a `packer/ubuntu/secrets.json`:

    {
      "esxi_password": "correct battery horse staple",
      "vcenter_password": "correct battery horse staple"
    }

Create a `terraform/secrets.tf` with

    variable vsphere-password {
      default = "correct battery horse staple"
    }

You might need to insert `esxi.fibernetcpe` and `vcenter.fibernetcpe` into your `/etc/hosts` to make the DNS resolution work.

You need the following installed:

* [Terraform](https://terraform.io)
* [Packer](https://packer.io)
* [ovftool](https://my.vmware.com/group/vmware/details?downloadGroup=OVFTOOL420&productId=491#) for which you need a free account.

### OVFTool on Mac

SHA256SUM: ab665f0c47ae03d45403e5c03a9c38b473beaab868920806c6f247e0590f89c3
VMware-ovftool-4.2.0-5965791-mac.x64.dmg

Installed as: /Applications/VMware\ OVF\ Tool/ovftool

    $ ln -s /Applications/VMware\ OVF\ Tool/ovftool ~/bin/

## Packer

Validate your packer file

    $ cd packer/ubuntu
    $ packer validate -var-file=secrets.json ubuntu-1604-server-base.json

Build an image

    $ packer build -var-file=secrets.json ubuntu-1604-server-base.json

If you are refused SSH access, then check the [the host setup](vsphere-setup.md).

## Terraform

    $ cd terraform
    $ terraform plan
    $ terraform apply

### Todo

* Compatibility mode of VM?
* Do we need the [vSphere CLI](https://github.com/vmware/govmomi/tree/master/govc) (govc) installed?

