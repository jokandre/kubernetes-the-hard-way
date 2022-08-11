#!/bin/bash
set -e
IFNAME=$1
ADDRESS="$(ip -4 addr show $IFNAME | grep "inet" | head -1 |awk '{print $2}' | cut -d/ -f1)"

# remove ubuntu-bionic entry
sed -e '/^.*ubuntu-focal.*/d' -i /etc/hosts
# sed -e '/^.*master-*/d' -i /etc/hosts
# sed -e '/^.*worker-*/d' -i /etc/hosts
# sed -e '/^.*lb*/d' -i /etc/hosts


sed -e "s/^.*${HOSTNAME}.*/${ADDRESS} ${HOSTNAME} ${HOSTNAME}.local/" -i /etc/hosts


# Update /etc/hosts about other hosts
cat >> /etc/hosts <<EOF
192.168.56.11  master-1
192.168.56.12  master-2
192.168.56.21  worker-1
192.168.56.22  worker-2
192.168.56.30  lb
EOF
