#!/bin/bash
# Hyun-gwan Seo

HOSTNAME=`hostname`

xl info > xl_info-$HOSTNAME.txt

cat /proc/cpuinfo > cpuinfo-$HOSTNAME.txt

cat /proc/meminfo > meminfo-$HOSTNAME.txt
free -h > free_h-$HOSTNAME.txt

dmidecode -t memory > dmidecode_memory-$HOSTNAME.txt
dmidecode -t bios > dmidecode_bios-$HOSTNAME.txt
dmidecode -t system > dmidecode_system-$HOSTNAME.txt


parted -l > parted_l-$HOSTNAME.txt
df -Th > df_Th-$HOSTNAME.txt

lspci  | grep -i raid > raid-$HOSTNAME.txt

cp /etc/network/interfaces interfaces-$HOSTNAME.txt

brctl show > brctlshow-$HOSTNAME.txt
ifconfig > ifconfig-$HOSTNAME.txt
route > route-$HOSTNAME.txt

lshw > lshw-$HOSTNAME.txt
dmidecode > dmidecode-$HOSTNAME.txt

dmesg > dmesg-$HOSTNAME.txt
cat /var/log/kern.log > kern.log-$HOSTNAME.txt
dpkg -l > dpkg_l-$HOSTNAME.txt
lsmod > lsmod-$HOSTNAME.txt
uname -a > uname_a-$HOSTNAME.txt
cat /etc/fstab > fstab-$HOSTNAME.txt
cat /etc/default/grub > grub-$HOSTNAME.txt
dstat 1 10 > dstat-$HOSTNAME.txt

