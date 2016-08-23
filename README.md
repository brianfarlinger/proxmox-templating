# proxmox-templating
Some small bash scripts to help setup proxmox VM templates

# Things you'll need to note:
- This does not change the FS UUIDs. If you want to change those, you'll need to edit the first-config script. 
- This is specific to Proxmox template setups. If you're using libvirt I would suggest checking out virt-sysprep. It works wonders.
- All configuration on the template is done through the root user account. Other user accounts can be added by the first-config script. 
