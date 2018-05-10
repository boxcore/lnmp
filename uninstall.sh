#!/bin/bash

# Check if user is root
if [ $(id -u) != "0" ]; then
    echo "Error: You must be root to run this script, use sudo sh $0"
    exit 1
fi

clear
echo "========================================================================="
echo "LNMP V0.8 for CentOS/RadHat Linux VPS  Written by Licess"
echo "========================================================================="
echo "A tool to auto-compile & install Nginx+MySQL+PHP on Linux "
echo ""
echo "For more information please visit http:/www.lnmp.org/"
echo ""
echo "Please backup your mysql data and configure files first!!!!!"
echo ""
echo "========================================================================="

echo ""
echo "Please backup your mysql data!!!!!"

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
	echo "Press any key to start uninstall LNMP , please wait ......"
	char=`get_char`

killall nginx
/etc/init.d/mysql stop
killall mysqld
/usr/local/php/sbin/php-fpm stop
killall php-cgi

rm -rf /usr/local/php

rm -rf /usr/local/nginx

rm -rf /usr/local/mysql

rm -rf /usr/local/zend

rm /etc/my.cnf
rm /etc/init.d/mysql
rm /root/vhost.sh
rm /root/lnmp
rm /root/run.sh

echo "Lnmp Uninstall completed."

echo "========================================================================="
echo "LNMP V0.8 for CentOS/RadHat Linux VPS  Written by Licess "
echo "========================================================================="
echo "A tool to auto-compile & install Nginx+MySQL+PHP on Linux "
echo ""
echo "For more information please visit http://www.lnmp.org/"
echo ""
echo "========================================================================="