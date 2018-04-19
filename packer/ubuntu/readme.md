# Creating images for VMWare ESXi

## Inital setup

### Enable SSH on ESXi host

To be able to SSH into the host, in the vSphere Client GUI, select the host, then Actions/Services/EnableSSH. (This setting will be reset after a reboot of the ESXi.)

Then SSH into the host, and run

    [root@esxi:~] esxcli system settings advanced set -o /Net/GuestIPHack -i 1

(Or use the GUI: Host/Manage/System/AdvancedSettings set _GuestIPHack_ set to 1. This vaule _will_ be kept after reboot.)

To avoid the username/password access, SSH into the host and add your public SSH key to `/etc/ssh/keys-root/authorized_keys`.

### Create datacenter and cluster on vCenter

Through the Web GUI (Flash) on vCenter, create `datacenter1` by right-clicking on the vcenter tree in the left pane, then right-click on the datacenter to create `cluster1`, right-click on the cluster to add a host, and there user `esxi.fibernetcpe`. Now tree should look like

![vCenter resource tree](vcenter-resource-tree.png)

### Opening ports for VNC

The firewall on the ESXi host will by default filter out the VNC range TCP 5900-5911 that Packer uses. You can see what is enabled by SSHing into the host and [run](https://docs.vmware.com/en/VMware-vSphere/6.5/com.vmware.vsphere.security.doc/GUID-7A8BEFC8-BF86-49B5-AE2D-E400AAD81BA3.html)

    $ esxcli network firewall ruleset list

To see the actual port ranges, run

    $ esxcli network firewall ruleset rule list

Make sure the services _CIMHttpServer_ & _CIMHttpsServer_ are enabled because they make the firewall open ports 5988 & 5989.

    esxcli network firewall ruleset set --enabled=true --ruleset-id=CIMHttpServer
    esxcli network firewall ruleset set --enabled=true --ruleset-id=CIMHttpsServer

(Alternatively, see https://nickcharlton.net/posts/using-packer-esxi-6.html)

## Todo

See https://github.com/nickcharlton/packer-esxi/blob/master/ubuntu-1604-base.json and open-vm-tools.sh

## Generate SSH key on ESXi host.

Don't know why you would need this, but here it is:

    /usr/lib/vmware/openssh/bin/ssh-keygen

## Trouble shooting

See https://groups.google.com/forum/#!topic/packer-tool/ZPuTeTagtqU, https://nickcharlton.net/posts/using-packer-esxi-6.html

Generating OVA: https://github.com/hashicorp/packer/issues/4832

### OVFTool on Mac

https://my.vmware.com/group/vmware/details?downloadGroup=OVFTOOL420&productId=491#

SHA256SUM: ab665f0c47ae03d45403e5c03a9c38b473beaab868920806c6f247e0590f89c3
VMware-ovftool-4.2.0-5965791-mac.x64.dmg

Installed as: /Applications/VMware\ OVF\ Tool/ovftool

    $ ln -s /Applications/VMware\ OVF\ Tool/ovftool ~/bin/
