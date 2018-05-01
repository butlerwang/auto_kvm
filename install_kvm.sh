#!/bin/bash

yum -y install qemu-kvm libvirt virt-install bridge-utils
yum -y install mkisofs  genisoimage virt-install libguestfs-tools-c qemu-img libvirt-client libvirt-nss
lsmod | grep kvm
midir -p /data/cache5/kvm/{virt,iso}
cd /data/cache5/kvm/iso
wget http://mirrors.aliyun.com/centos/7/isos/x86_64/CentOS-7-x86_64-Minimal-1708.iso
mv /var/lib/libvirt/images /data/cache5/kvm/virt/
ln -sf /data/cache5/kvm/virt/images/ /var/lib/libvirt/images
