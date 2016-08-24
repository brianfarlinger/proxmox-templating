#!/bin/bash

#Use this script to clean out UUIDs, log files, etc. Final step of setting up a template

echo "Now cleaning up files and removing UUIDs"

#clean up cached yum files
yum clean all

#flush the logs
logrotate –f /etc/logrotate.conf
rm –f /var/log/*-???????? /var/log/*.gz
rm -f /var/log/dmesg.old
rm -rf /var/log/anaconda
cat /dev/null > /var/log/audit/audit.log
cat /dev/null > /var/log/wtmp
cat /dev/null > /var/log/lastlog
cat /dev/null > /var/log/grubby

#remove temp files
rm –rf /tmp/*
rm –rf /var/tmp/*

#remove hardware specific information associated with eth0
sed -i ‘/^(HWADDR|UUID)=/d’ /etc/sysconfig/network-scripts/ifcfg-eth0

#remove SSH keys
rm –f /etc/ssh/*key*

#remove bash history and SSH history from root user. 
rm -f ~root/.bash_history
unset HISTFILE
rm -rf ~root/.ssh/
rm -f ~root/anaconda-ks.cfg
