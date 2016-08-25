#!/bin/bash

#Variables unique to environment
DNS1="192.168.69.20"
DNS2="8.8.8.8"
GATEWAY="192.168.69.1"

#I run this script on the first boot of every VM I create by template.

#changing the hostname and configuring the network using NetworkManager.
echo -n "What is the hostname of this server?:"
read HOSTNAME
hostnamectl set-hostname $HOSTNAME
systemctl restart systemd-hostnamed

echo -n "Do you want to setup a static IP address? [y/N]:"
read ipyn
loweripyn=$(echo "$ipyn" | awk '{print tolower($0)}')
if [ "$loweripyn" == "yes" -o "$loweripyn" == "ye" -o "$loweripyn" == "y" ]
  then
    echo -n "What IP address would you like to use?"
    read IP
    echo -n "What is the subnet? (use CIDR) [24]"
    read subnet
    if [ $SUBNET == ""]
      then
        SUBNET="24"
    fi
    echo "Use $IP/$SUBNET? [Press any button to proceed]"
    read proceed
    nmcli con delete eth0
    nmcli con add con-name eth0 ifname eth0 type ethernet ip4 "$IP/$SUBNET" gw4 "$GATEWAY"
    nmcli con modify eth0 ipv4.dns "$DNS1 $DNS2"
  else
    echo "A DHCP address will be assigned. [Press any button to proceed]"
    read proceed
    nmcli con delete eth0
    nmcli con add con-name eth0 ifname eth0 type ethernet
    nmcli con modify eth0 ipv4.dhcp-send-hostname yes
fi
systemctl restart network

#example of other stuff you can do. Adds the system to FreeIPA
ipa-client-install --server=freeipa.lilac.red --domain=lilac.red --mkhomedir --hostname=$hostname --principal=join --password=MQIZE10ruI85tVkWaJI5 --unattended

#Restart the system
reboot
