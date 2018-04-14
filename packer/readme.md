# Creating images for VMWare ESXi

## Inital setup

To be able to SSH into the host, in the vSphere Client GUI, select the host, then Actions/Services/EnableSSH.

Then SSH into the host, and run

    esxcli system settings advanced set -o /Net/GuestIPHack -i 1

(Or use the GUI: Host/Manage/AdvancedSettings set _GuestIPHack_ set to 1)

To avoid the username/password access, run

    /usr/lib/vmware/openssh/bin/ssh-keygen

and generate an SSH key.

## Trouble shooting

See https://groups.google.com/forum/#!topic/packer-tool/ZPuTeTagtqU, https://nickcharlton.net/posts/using-packer-esxi-6.html
