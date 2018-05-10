#!/bin/bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

# Check if user is root
if [ $(id -u) != "0" ]; then
    echo "Error: You must be root to run this script, please use root to install lnmp"
    exit 1
fi

clear
printf "=======================================================================\n"
printf "Install ionCube for LNMP V0.8  ,  Written by Licess \n"
printf "=======================================================================\n"
printf "LNMP is a tool to auto-compile & install Nginx+MySQL+PHP on Linux \n"
printf "This script is a tool to install eAccelerator for lnmp \n"
printf "\n"
printf "For more information please visit http://www.lnmp.org \n"
printf "=======================================================================\n"
cur_dir=$(pwd)

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
	echo "Press any key to start install ionCube..."
	char=`get_char`

printf "=========================== install eaccelerator ======================\n"
php_version=`php -r 'echo PHP_VERSION;'`

if [ `getconf WORD_BIT` = '32' ] && [ `getconf LONG_BIT` = '64' ] ; then
        cd /usr/local/
	wget -c http://downloads2.ioncube.com/loader_downloads/ioncube_loaders_lin_x86-64.tar.gz
	tar zxvf ioncube_loaders_lin_x86-64.tar.gz
else
        cd /usr/local/
	wget -c http://downloads2.ioncube.com/loader_downloads/ioncube_loaders_lin_x86.tar.gz
	tar zxvf ioncube_loaders_lin_x86.tar.gz
fi

sed -i '/ionCube Loader/d' /usr/local/php/etc/php.ini
sed -i '/ioncube_loader_lin/d' /usr/local/php/etc/php.ini

if [ $php_version = "5.2.14" ] || [ $php_version = "5.2.15" ] || [ $php_version = "5.2.16" ] || [ $php_version = "5.2.17" ] || [ $php_version = "5.2.17p1" ]; then
cat >ionCube.ini<<EOF
[ionCube Loader]
zend_extension="/usr/local/ioncube/ioncube_loader_lin_5.2.so"
EOF

sed -i '/;ionCube/ {
r ionCube.ini
}' /usr/local/php/etc/php.ini

echo "Reload php-fpm......"
/etc/init.d/php-fpm restart
else
cat >ionCube.ini<<EOF
[ionCube Loader]
zend_extension="/usr/local/ioncube/ioncube_loader_lin_5.3.so"
EOF

sed -i '/;ionCube/ {
r ionCube.ini
}' /usr/local/php/etc/php.ini

if [ -s /etc/init.d/httpd ] && [ -s /usr/local/apache ]; then
echo "Restarting Apache......"
/etc/init.d/httpd restart
else
echo "Restarting php-fpm......"
/etc/init.d/php-fpm restart
fi

fi

rm ionCube.ini
printf "===================== install ionCube completed ===================\n"

clear
printf "Install ionCube completed,enjoy it!\n"
printf "=======================================================================\n"
printf "Install ionCube for LNMP V0.8  ,  Written by Licess \n"
printf "=======================================================================\n"
printf "LNMP is a tool to auto-compile & install Nginx+MySQL+PHP on Linux \n"
printf "This script is a tool to install eAccelerator for lnmp \n"
printf "\n"
printf "For more information please visit http://www.lnmp.org \n"
printf "=======================================================================\n"