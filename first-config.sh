#!/bin/bash

#I run this script on the first boot of every VM I create by template.
/bin/echo -n "What is the hostname of this server?:"
/usr/bin/read HOSTNAME
hostnamectl set-hostname $HOSTNAME
systemctl restart systemd-hostnamed

/bin/echo -n "Is a static IP address required? [Y/n]:"





#environment specific commands
