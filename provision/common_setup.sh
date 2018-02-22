#!/bin/sh
echo gluu_version: $version
echo hostname: $hostname
echo ip: $ip
echo "set file limits..."
echo "* soft nofile 65536" >> /etc/security/limits.conf
echo "* hard nofile 261144" >> /etc/security/limits.conf
echo "65535" > /proc/sys/fs/file-max** 
echo "session    required     pam_limits.so" >> /etc/pam.d/login
echo "127.0.0.1   $hosextname" >> /etc/hosts 
hostnamectl set-hostname $hostname
sysctl -p