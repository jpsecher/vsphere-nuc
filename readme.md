# Terraforming VMWare VSphere ESXi

The target machine is an Intel NUC with 32GB RAM and 2 x 256GB SSD disks.

Plan:

* [x] Get contact to VSphere through Terraform.
* [x] Create a virtual disk.
* [ ] Create and deploy a new image with Packer.
* [ ] Create a virtual machine with the disk attached.
* [ ] Create a cluster that Docker Swarm can run on.
* [ ] Create a Gluster host for persistent storage.
* [ ] Get Docker GetStarted example to run on Gluster-backed storage.

## Initial setup

Get the SSH key `esxi-lundogbendsen_rsa` an put it in your `~/.ssh`.

Create a `packer/esxi/variables.json` and insert the SSH key path:

    {
      "private_ssh_key_file": "/Users/jps/.ssh/esxi-lundogbendsen_rsa",
      "esxi_host": "192.168.1.22",
      "esxi_network": "VM Network",
      "esxi_datastore": "datastore1",
      "esxi_user": "root",
      "version": "v5"
    }

## Packer

Build an image

```
    $ cd packer/esxi
    $ packer build -var-file=variables.json ubuntu-1604-server-base.json
```

Validate your packer file

```
    $ cd packer/esxi
    $ packer validate -var-file=variables.json  ubuntu-1604-server-base.json
```

In my setup /etc/hosts has a line esxi X.Y.Z.X with the IP my test box has on the network.

Create a `packer/esxi/secrets.json` and insert user,pass for the vcenter.fibernetcpe

```
{
  "username": "root",
  "password": "PASSWORD",
}
```

### Todo

* Compatibility mode of VM?

## Terraform

    $ cd terraform
    $ terraform plan
    $ terraform apply

# What do I need to run this

* terraform, version unknown
* requires Packer version 1.2.2 or higher;
* a secret to access VMWare
* ovftool (I downloaded it from VMWare. needed a login)