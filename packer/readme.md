# Creating images for VMWare ESXi

## Inital setup

To be able to SSH into the host, in the vSphere Client GUI, select the host, then Actions/Services/EnableSSH. (This setting will be reset after a reboot of the ESXi.)

Then SSH into the host, and run

    esxcli system settings advanced set -o /Net/GuestIPHack -i 1

(Or use the GUI: Host/Manage/System/AdvancedSettings set _GuestIPHack_ set to 1. This vaule _will_ be kept after reboot.)

To avoid the username/password access, SSH into the host and add your public SSH key to `/etc/ssh/keys-root/authorized_keys`.

## Opening ports for VNC

The firewall on the ESXi host will by default filter out the VNC range TCP 5900-5911 that Packer uses. You can see what is enabled by SSHing into the host and [run](https://docs.vmware.com/en/VMware-vSphere/6.5/com.vmware.vsphere.security.doc/GUID-7A8BEFC8-BF86-49B5-AE2D-E400AAD81BA3.html)

    $ esxcli network firewall ruleset list

To see the actual port ranges, run

    $ esxcli network firewall ruleset rule list

Enable these services:

CIMHttpServer 5988
CIMHttpsServer 5989

    esxcli network firewall ruleset set --enabled=true --ruleset-id=CIMHttpServer

## Generate SSH key on ESXi host.

    /usr/lib/vmware/openssh/bin/ssh-keygen

## Trouble shooting

See https://groups.google.com/forum/#!topic/packer-tool/ZPuTeTagtqU, https://nickcharlton.net/posts/using-packer-esxi-6.html

"This VM is attached to a network portgroup that doesn't exist. Edit this VM and attach it to a different network."
"The portgroup for Network adapter 1, , could not be found. It has been assigned to VM Network."
