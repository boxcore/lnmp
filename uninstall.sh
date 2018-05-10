#!/bin/bash

# Check if user is root
if [ $(id -u) != "0" ]; then
    echo "Error: You must be root to run this script, use sudo sh $0"
    exit 1
fi

clear
echo "========================================================================="
echo "LNMP V0.3 for CentOS/RadHat Linux VPS  Written by Licess"
echo "========================================================================="
echo "A tool to auto-compile & install Nginx+MySQL+PHP on Linux "
echo "For more information please visit http://blog.licess.cn/lnmp/"
echo ""
echo ""
echo "The path of some dirs:"
echo "mysql dir:   /usr/local/mysql"
echo "php dir:     /usr/local/php"
echo "nginx dir:   /usr/local/nginx"
echo "web dir      /home/wwwroot"
echo ""
echo "========================================================================="

echo ""
echo "starting uninstall LNMP now , please wait ..."
echo ""
echo "Please backup your mysql data!!!!!"

rm -rf /usr/local/nginx
rm -rf /usr/local/mysql
rm -rf /usr/local/php
rm -rf /usr/local/zend

echo "Lnmp Uninstall completed."

clear
echo "========================================================================="
echo "LNMP V0.3 for CentOS/RadHat Linux VPS  Written by Licess "
echo "========================================================================="
echo ""
echo "For more information please visit http://blog.licess.cn/lnmp/"
echo ""
echo "run nginx+php-cgi: /root/run.sh"
echo "default mysql root password:root"
echo "phpinfo test: http://domain.name/phpinfo.php"
echo "phpMyAdmin test: http://domain.name/phpmyadmin"
echo "Prober : http://domain.name/prober.php"
echo "The path of some dirs:"
echo "mysql dir:   /usr/local/mysql"
echo "php dir:     /usr/local/php"
echo "nginx dir:   /usr/local/nginx"
echo "web dir      /home/wwwroot"
echo ""
echo "========================================================================="