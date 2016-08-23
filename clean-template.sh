#!/bin/bash

#Use this script to clean out UUIDs, log files, etc. Final step of setting up a template

/bin/echo "Now cleaning up files and removing UUIDs"

#clean up cached yum files
/usr/bin/yum clean all

#flush the logs
/usr/sbin/logrotate –f /etc/logrotate.conf
/bin/rm –f /var/log/*-???????? /var/log/*.gz
/bin/rm -f /var/log/dmesg.old
/bin/rm -rf /var/log/anaconda
/bin/cat /dev/null > /var/log/audit/audit.log
/bin/cat /dev/null > /var/log/wtmp
/bin/cat /dev/null > /var/log/lastlog
/bin/cat /dev/null > /var/log/grubby

#remove temp files
/bin/rm –rf /tmp/*
/bin/rm –rf /var/tmp/*

#remove hardware specific information associated with eth0
/bin/sed -i ‘/^(HWADDR|UUID)=/d’ /etc/sysconfig/network-scripts/ifcfg-eth0

#remove SSH keys
/bin/rm –f /etc/ssh/*key*

#remove bash history and SSH history from root user. 
/bin/rm -f ~root/.bash_history
unset HISTFILE
/bin/rm -rf ~root/.ssh/
/bin/rm -f ~root/anaconda-ks.cfg
