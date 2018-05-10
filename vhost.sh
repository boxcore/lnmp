#!/bin/bash

# Check if user is root
if [ $(id -u) != "0" ]; then
    echo "Error: You must be root to run this script, use sudo sh $0"
    exit 1
fi

clear
echo "========================================================================="
echo "Add Virtual Host for LNMP V0.3  ,  Written by Licess "
echo "========================================================================="
echo "LNMP is a tool to auto-compile & install Nginx+MySQL+PHP on Linux "
echo "This script is a tool to add virtual host for nginx "
echo "For more information please visit http://blog.licess.cn/lnmp/"
echo ""
echo ""
echo "The path of some dirs:"
echo "mysql dir:   /usr/bin"
echo "php dir:     /usr/local/php"
echo "nginx dir:   /usr/local/nginx"
echo "web dir      /home/wwwroot"
echo ""
echo "========================================================================="

if [ "$1" != "--help" ]; then


	domain="www.lnmp.org"
	echo "Please input domain:"
	read -p "(Default domain: www.lnmp.org):" domain
	if [ "$domain" = "" ]; then
		domain="www.lnmp.org"
	fi
	echo "==========================="

	echo domain="$domain"

	echo "==========================="

	vhostdir="/home/wwwroot"
	echo "Please input the directory for the domain:$domain :"
	read -p "(Default directory: /home/wwwroot):" vhostdir
	if [ "$vhostdir" = "" ]; then
		vhostdir="/home/wwwroot"
	fi
	echo "==========================="

	echo Virtual Host Directory="$vhostdir"

	echo "==========================="

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
	echo "Press any key to start..."
	char=`get_char`

mkdir /usr/local/nginx/conf/vhost
cat >/usr/local/nginx/conf/vhost/$domain.conf<<eof
server
	{
		listen       80;
		server_name $domain;
		index index.html index.htm index.php default.html default.htm default.php;
		root  $vhostdir;

		location ~ .*\.(php|php5)?$
			{
				fastcgi_pass  unix:/tmp/php-cgi.sock;
				#fastcgi_pass  127.0.0.1:9000;
				fastcgi_index index.php;
				include fcgi.conf;
			}

		location ~ .*\.(gif|jpg|jpeg|png|bmp|swf)$
			{
				expires      30d;
			}

		location ~ .*\.(js|css)?$
			{
				expires      12h;
			}

		access_log   off;
	}
eof

echo "Create Virtul Host directory......"
mkdir $vhostdir
chmod 777 $vhostdir
echo ""
echo "Test Nginx configure file......"
/usr/local/nginx/sbin/nginx -t
echo ""
echo "Restart Nginx......"
kill -HUP `cat /usr/local/nginx/logs/nginx.pid`

clear
echo "========================================================================="
echo "Add Virtual Host for LNMP V0.3  ,  Written by Licess "
echo "========================================================================="
echo ""
echo "For more information please visit http://blog.licess.cn/lnmp/"
echo ""
echo "run nginx+php-cgi: /root/run.sh"
echo "default mysql root password:root"
echo "phpinfo test:http://localhost/phpinfo.php"
echo "phpMyAdmin test:http://localhost/phpmyadmin"
echo "The path of some dirs:"
echo "mysql dir:   /usr/bin"
echo "php dir:     /usr/local/php"
echo "nginx dir:   /usr/local/nginx"
echo "web dir      /home/wwwroot"
echo ""
echo "========================================================================="
fi