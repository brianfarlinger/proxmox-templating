#!/bin/bash

#Variables unique to environment
DNS1 = "192.168.69.20"
DNS2 = "8.8.8.8"

#I run this script on the first boot of every VM I create by template.

#changing the hostname and configuring the network using NetworkManager.
echo -n "What is the hostname of this server?:"
read HOSTNAME
hostnamectl set-hostname $HOSTNAME
systemctl restart systemd-hostnamed

echo -n "Do you want to setup a static IP address? [Y/n]:"
read ipyn
ipyn = ("$ipyn" | 
if [ awk '{print tolower($ipyn)}' == "no" -o awk '{print tolower($ipyn)}' == "n"]
  then
    nmcli con add con-name eth0 ifname eth0 type ethernet ipv4.dhcp-send-hostname yes
  else
    echo -n "What IP address would you like to use?"
    read $IP
    echo -n "What is the subnet? (use CIDR) [24]"
    read subnet
    if [ $subnet == ""]
      then
        subnet = 24
    nmcli con add con-name eth0 ifname eth0 type ethernet ip4 "$IP/$SUBNET" gw4 "$GATEWAY" dns ipv4.dns "$DNS1 $DNS2"
systemctl restart network

#environment specific commands
ipa-client-install --server=freeipa.lilac.red --domain=lilac.red --mkhomedir --hostname=$hostname --principal=join --password=MQIZE10ruI85tVkWaJI5 --unattended
