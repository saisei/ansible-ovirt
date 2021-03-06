#!/usr/bin/env bash

if [ "$EUID" -ne "0" ]; then
  echo "This script must be run as root." >&2
  exit 1
fi
(set -x

# example.org domains don't resolve with the original order
cat << EOF > /etc/resolv.conf
search example.org
nameserver 192.168.33.1
nameserver 192.168.121.1
EOF

# Write protect (to prevent dhclient from breaking it)
chattr +i /etc/resolv.conf

# Enable root ssh key access
cp -R /home/vagrant/.ssh /root/.ssh

# Enable ovirt.org repository
yum install -y http://resources.ovirt.org/pub/yum-repo/ovirt-release40.rpm

)
