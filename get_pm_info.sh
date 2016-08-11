#!/bin/bash
#Hyun-gwan Seo

HOSTNAME=`hostname`
BASE="$1"
HW_INFO_PATH="$BASE/hw_info"
PARTITIONS_DISK_PATH="$BASE/partitions_and_disk_info"
NET_INFO_PATH="$BASE/network_info"
SYS_STATUS_AND_SETTINGS_PATH="$BASE/sys_status_and_settings_info"

function init()
{
    if [ 0 -eq $# ]; then
        echo "Usage: $0 LOG_PATH"
    fi

    if [ ! -d $BASE ]; then
        mkdir -p $BASE
    fi

    if [ ! -d $HW_INFO_PATH ]; then
        mkdir -p $HW_INFO_PATH
    fi

    if [ ! -d $PARTITIONS_DISK_PATH ]; then
        mkdir -p $PARTITIONS_DISK_PATH
    fi

    if [ ! -d $NET_INFO_PATH ]; then
        mkdir -p $NET_INFO_PATH
    fi

    if [ ! -d $SYS_STATUS_AND_SETTINGS_PATH ]; then
        mkdir -p $SYS_STATUS_AND_SETTINGS_PATH
    fi
}

#HW 정보를 수집합니다.
function get_hw_info()
{
    dmidecode > $HW_INFO_PATH/dmidecode-$HOSTNAME.txt
    dmidecode -t memory > $HW_INFO_PATH/dmidecode_memory-$HOSTNAME.txt
    dmidecode -t bios > $HW_INFO_PATH/dmidecode_bios-$HOSTNAME.txt
    dmidecode -t system > $HW_INFO_PATH/dmidecode_system-$HOSTNAME.txt
    lspci  | grep -i raid > $HW_INFO_PATH/raid-$HOSTNAME.txt
    lshw > $HW_INFO_PATH/lshw-$HOSTNAME.txt
    cat /proc/cpuinfo > $HW_INFO_PATH/cpuinfo-$HOSTNAME.txt
    cat /proc/meminfo > $HW_INFO_PATH/meminfo-$HOSTNAME.txt
}

#파티션과 디스크 정보를 수집합니다.
function partitions_and_disk_info()
{
    echo "Ignore" | parted -l > $PARTITIONS_DISK_PATH/parted_l-$HOSTNAME.txt
    df -Th > $PARTITIONS_DISK_PATH/df_Th-$HOSTNAME.txt
    fdisk -l > $PARTITIONS_DISK_PATH/fdisk_l-$HOSTNAME.txt
}


#네트워크 정보를 수집합니다.
function get_network_info()
{
    cp /etc/network/interfaces $NET_INFO_PATH/interfaces-$HOSTNAME.txt
    brctl show > $NET_INFO_PATH/brctlshow-$HOSTNAME.txt
    ifconfig > $NET_INFO_PATH/ifconfig-$HOSTNAME.txt
    route > $NET_INFO_PATH/route-$HOSTNAME.txt
}

#시스템 상태 및 설정 값을 수집합니다.
function get_system_status_and_settings()
{
    dmesg > $SYS_STATUS_AND_SETTINGS_PATH/dmesg-$HOSTNAME.txt
    cat /var/log/kern.log > $SYS_STATUS_AND_SETTINGS_PATH/kern.log-$HOSTNAME.txt
    dpkg -l > $SYS_STATUS_AND_SETTINGS_PATH/dpkg_l-$HOSTNAME.txt
    lsmod > $SYS_STATUS_AND_SETTINGS_PATH/lsmod-$HOSTNAME.txt
    uname -a > $SYS_STATUS_AND_SETTINGS_PATH/uname_a-$HOSTNAME.txt
    cat /etc/fstab > $SYS_STATUS_AND_SETTINGS_PATH/fstab-$HOSTNAME.txt
    cat /etc/default/grub > $SYS_STATUS_AND_SETTINGS_PATH/grub-$HOSTNAME.txt
    dstat 1 10 > $SYS_STATUS_AND_SETTINGS_PATH/dstat-$HOSTNAME.txt
    xl info > $SYS_STATUS_AND_SETTINGS_PATH/xl_info-$HOSTNAME.txt
    xl list > $SYS_STATUS_AND_SETTINGS_PATH/xl_list-$HOSTNAME.txt
    free -h > $SYS_STATUS_AND_SETTINGS_PATH/free_h-$HOSTNAME.txt
}

init
get_hw_info
partitions_and_disk_info
get_network_info
get_system_status_and_settings
