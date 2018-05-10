#!/bin/bash

# Check if user is root
if [ $(id -u) != "0" ]; then
    echo "Error: You must be root to run this script, use sudo sh $0"
    exit 1
fi

clear
echo "========================================================================="
echo "Vsftpd for LNMP V0.4  ,  Written by Licess "
echo "========================================================================="
echo "LNMP is a tool to auto-compile & install Nginx+MySQL+PHP on Linux "
echo "This script is a tool to install VSftp for LNMP "
echo ""
echo "For more information please visit http://www.lnmp.org/"
echo "========================================================================="
echo ""
	get_char()
	{
	SAVEDSTTY=`stty -g`
	stty -echo
	stty cbreak
	dd if=/dev/tty bs=1 count=1 2> /dev/null
	stty -raw
	stty echo
	stty $SAVEDSTTY
	}
	echo ""
	echo "Press any key to start install VSftpd..."
	char=`get_char`

wget -c http://soft.vpser.net/ftp/vsftpd/vsftpd-2.2.2.tar.gz
echo "download vsftpd package finished!"
echo "installing vsftpd 2.2.2......."

useradd nobody

tar zxf vsftpd-2.2.2.tar.gz
cd vsftpd-2.2.2/
mkdir /usr/local/man/man8
mkdir /usr/local/man/man5
make && make install
cd ../

cp conf/vsftpd.conf /etc/
mkdir /etc/vsftpd
touch /etc/vsftpd/chroot_list
echo "/usr/local/sbin/vsftpd &" >> /etc/rc.local
mkdir /var/ftp
touch /etc/vsftpd/userlist.chroot
touch /etc/vsftpd/userlist_deny.chroot
touch /var/log/vsftpd.log

/usr/local/sbin/vsftpd &
setsebool -P ftpd_disable_trans on
/sbin/iptables -I INPUT -p tcp --dport 21 -j ACCEPT
/etc/rc.d/init.d/iptables save
/etc/init.d/iptables restart
useradd -d /home/wwwroot -s /sbin/nologin adminftp
pkill vsftpd
/usr/local/sbin/vsftpd &

clear
echo "========================================================================="
echo "Vsftpd for LNMP V0.4  ,  Written by Licess "
echo "========================================================================="
echo "LNMP is a tool to auto-compile & install Nginx+MySQL+PHP on Linux "
echo "This script is a tool to install VSftp for LNMP "
echo ""
echo "For more information please visit http://www.lnmp.org/"
echo ""
echo "The path of some dirs:"
echo "run vsftpd:   /usr/local/sbin/vsftpd & "
echo "kill vsftpd process:     pkill vsftpd "
echo "test ftp user: "adminftp", you need run "passwd adminftp" to modify password!!! or delete the user!"
echo "web dir      /home/wwwroot"
echo ""
echo "========================================================================="