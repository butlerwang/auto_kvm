#!/usr/bin/env bash

#Download ks.cfg
wget http://dev.ccnanext.com/tools/ks.cfg -O ks.cfg
# Update kickstart file
echo -en "Enter Hostname: "
read HOST_NAME
echo -en "Enter IP Address: "
read IP_ADDRESS
sudo sed -i 's/server1/'$HOST_NAME'/g' ./ks.cfg
sudo sed -i 's/192.168.122.100/'$IP_ADDRESS'/g' ./ks.cfg
 
## Pre-defined variables
echo ""
MEM_SIZE=4096
VCPUS=2
OS_VARIANT="rhel7"
#ISO_FILE="$HOME/iso/CentOS-7-x86_64-Everything-1611.iso"
ISO_FILE="/data/cache5/kvm/virt/iso/CentOS-7-x86_64-Minimal-1708.iso"

echo -en "Enter vm name: "
read VM_NAME
OS_TYPE="linux"
echo -en "Enter virtual disk size : "
read DISK_SIZE
 
sudo virt-install \
     --name ${VM_NAME} \
     --memory=${MEM_SIZE} \
     --vcpus=${VCPUS} \
     --os-type ${OS_TYPE} \
     --location ${ISO_FILE} \
     --disk size=${DISK_SIZE}  \
     --network bridge=virbr0 --network bridge=docker0 \
     --graphics=none \
     --os-variant=${OS_VARIANT} \
     --console pty,target_type=serial \
     -x 'console=ttyS0,115200n8 serial' \
     -x "ks=./ks.cfg"
