#!/bin/sh
#改编自 www.lijian.me
#源文件来自 https://linux.qq.com/?p=238
PATH=$PATH:/sbin:/usr/sbin:/usr/local/sbin:$HOME/bin:/usr/local/bin:/usr/bin
export PATH
export LANG=en_US.UTF-8

yum -y install epel-release net-tools bzip2

curl -o /tmp/tcpa_packets_180619_1151.tar.bz2 https://raw.githubusercontent.com/ivmm/TCPA/master/tcpa_packets_180619_1151.tar.bz2
chmod +x /etc/rc.d/rc.local
cat>>/etc/rc.local<<EOF
####tcpa####
cd /tmp/
tar jxvf tcpa_packets_180619_1151.tar.bz2
cd tcpa_packets
sh install.sh
cd /usr/local/storage/tcpav2
sh start.sh
lsmod|grep tcpa
rm -f /tmp/tcpa_packets_180619_1151.tar.bz2
rm -rf /tmp/tcpa_packets
sed -i '/####tcpa####/','/####tcpa####/d' /etc/rc.local
####tcpa####
EOF

rpm -ivh https://raw.githubusercontent.com/ivmm/TCPA/master/kernel-3.10.0-693.5.2.tcpa06.tl2.x86_64.rpm --force
echo "内核安装完毕,3秒后将自动重启..."
echo "重启后安装自动完成,lsmod|grep tcpa查看是否开启成功."
sleep 3
reboot
