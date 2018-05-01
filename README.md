# auto_kvm
kvm automation scritps

## install kvm
yum -y install qemu-kvm libvirt virt-install bridge-utils
yum -y install mkisofs  genisoimage virt-install libguestfs-tools-c qemu-img libvirt-client libvirt-nss
lsmod | grep kvm
midir -p /data/cache5/kvm/{virt,iso}
cd /data/cache5/kvm/iso
wget http://mirrors.aliyun.com/centos/7/isos/x86_64/CentOS-7-x86_64-Minimal-1708.iso
mv /var/lib/libvirt/images /data/cache5/kvm/virt/
ln -sf /data/cache5/kvm/virt/images/ /var/lib/libvirt/images

##virsh basic
virsh list --all
virsh shutdown centos7-1
virsh destroy centos7-1
virsh undefine centos7-1
virsh  console centos7_0 #login
ctrl + 5 or ctrl ] #logout
virsh net-list
virsh dumpxml centos7-1
virsh net-dumpxml default

##clone && change hostname and ip
virt-clone -o centos7_temp -n centos7-2 --auto-clone
virt-sysprep --hostname centos7-5  --firstboot-command 'sed -i "s#192.168.122.100#192.168.122.105#g" /etc/sysconfig/network-scripts/ifcfg-eth0' -d centos7-5

## kvm port forwarding
iptables -I FORWARD -o virbr0 -d 192.168.122.101 -j ACCEPT
iptables -t nat -I PREROUTING -p tcp --dport 10122 -j DNAT --to 192.168.122.101:22
