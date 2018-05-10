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
printf "Install eAcesselerator for LNMP V0.8  ,  Written by Licess \n"
printf "=======================================================================\n"
printf "LNMP is a tool to auto-compile & install Nginx+MySQL+PHP on Linux \n"
printf "This script is a tool to install eAccelerator for lnmp \n"
printf "\n"
printf "For more information please visit http://www.lnmp.org \n"
printf "=======================================================================\n"
cur_dir=$(pwd)

	ver="old"
	echo "Which version do you want to install:"
	echo "Install eaccelerator 0.9.5.3 please type: old"
	echo "Install eaccelerator 0.9.6.1 please type: new"
	read -p "Type old or new (Default version old):" ver
	if [ "$ver" = "" ]; then
		ver="old"
	fi

	if [ "$ver" = "old" ]; then
		echo "You will install eaccelerator 0.9.5.3"
	else
		echo "You will install eaccelerator 0.9.6.1"
	fi

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
	echo "Press any key to start...or Press Ctrl+c to cancel"
	char=`get_char`

printf "=========================== install eaccelerator ======================\n"

if [ -s /usr/local/php/lib/php/extensions/no-debug-non-zts-20060613/eaccelerator.so ]; then
rm -f /usr/local/php/lib/php/extensions/no-debug-non-zts-20060613/eaccelerator.so
elif [ -s /usr/local/php/lib/php/extensions/no-debug-non-zts-20090626/eaccelerator.so ]; then
rm -f /usr/local/php/lib/php/extensions/no-debug-non-zts-20090626/eaccelerator.so
fi

#Install eaccelerator 0.9.5.3
function install_old_ea {
if [ -s eaccelerator-0.9.5.3 ]; then
rm -rf eaccelerator-0.9.5.3/
fi
now_php_version=`php -r 'echo PHP_VERSION;'`
echo $now_php_version | grep '5.3.*'
if [ $? -eq 0 ]; then
echo "PHP 5.3.* Can't install eaccelerator 0.9.5.3!"
exit 1
fi
wget -c http://soft.vpser.net/web/eaccelerator/eaccelerator-0.9.5.3.tar.bz2
tar jxvf eaccelerator-0.9.5.3.tar.bz2
cd eaccelerator-0.9.5.3/
/usr/local/php/bin/phpize
./configure --enable-eaccelerator=shared --with-php-config=/usr/local/php/bin/php-config --with-eaccelerator-shared-memory
make
make install
cd ../
}

#Install eaccelerator 0.9.6.1
function install_new_ea {
if [ -s eaccelerator-0.9.6.1 ]; then
rm -rf eaccelerator-0.9.6.1/
fi

wget -c http://soft.vpser.net/web/eaccelerator/eaccelerator-0.9.6.1.tar.bz2
tar jxvf eaccelerator-0.9.6.1.tar.bz2
cd eaccelerator-0.9.6.1/
/usr/local/php/bin/phpize
./configure --enable-eaccelerator=shared --with-php-config=/usr/local/php/bin/php-config --with-eaccelerator-shared-memory
make
make install
cd ../
}

if [ "$ver" = "old" ]; then
	install_old_ea
else
	install_new_ea	
fi


mkdir -p /usr/local/eaccelerator_cache
sed -ni '1,/;eaccelerator/p;/;ionCube/,$ p' /usr/local/php/etc/php.ini

php_version=`php -r 'echo PHP_VERSION;'`

if [ $php_version = "5.2.14" ] || [ $php_version = "5.2.15" ] || [ $php_version = "5.2.16" ] || [ $php_version = "5.2.17" ]  || [ $php_version = "5.2.17p1" ]; then
cat >ea.ini<<EOF
[eaccelerator]
zend_extension="/usr/local/php/lib/php/extensions/no-debug-non-zts-20060613/eaccelerator.so"
eaccelerator.shm_size="1"
eaccelerator.cache_dir="/usr/local/eaccelerator_cache"
eaccelerator.enable="1"
eaccelerator.optimizer="1"
eaccelerator.check_mtime="1"
eaccelerator.debug="0"
eaccelerator.filter=""
eaccelerator.shm_max="0"
eaccelerator.shm_ttl="3600"
eaccelerator.shm_prune_period="3600"
eaccelerator.shm_only="0"
eaccelerator.compress="1"
eaccelerator.compress_level="9"
eaccelerator.keys = "disk_only"
eaccelerator.sessions = "disk_only"
eaccelerator.content = "disk_only"

EOF

sed -i '/;eaccelerator/ {
r ea.ini
}' /usr/local/php/etc/php.ini

echo "Restarting php-fpm......"
/etc/init.d/php-fpm restart

else
cat >ea.ini<<EOF
[eaccelerator]
zend_extension="/usr/local/php/lib/php/extensions/no-debug-non-zts-20090626/eaccelerator.so"
eaccelerator.shm_size="1"
eaccelerator.cache_dir="/usr/local/eaccelerator_cache"
eaccelerator.enable="1"
eaccelerator.optimizer="1"
eaccelerator.check_mtime="1"
eaccelerator.debug="0"
eaccelerator.filter=""
eaccelerator.shm_max="0"
eaccelerator.shm_ttl="3600"
eaccelerator.shm_prune_period="3600"
eaccelerator.shm_only="0"
eaccelerator.compress="1"
eaccelerator.compress_level="9"
eaccelerator.keys = "disk_only"
eaccelerator.sessions = "disk_only"
eaccelerator.content = "disk_only"

EOF

sed -i '/;eaccelerator/ {
r ea.ini
}' /usr/local/php/etc/php.ini

if [ -s /etc/init.d/httpd ] && [ -s /usr/local/apache ]; then
echo "Restarting Apache......"
/etc/init.d/httpd -k restart
else
echo "Restarting php-fpm......"
/etc/init.d/php-fpm restart
fi

fi

rm ea.ini
clear

printf "===================== install eaccelerator completed ===================\n"
printf "Install eAccelerator completed,enjoy it!\n"
printf "=======================================================================\n"
printf "Install eAcesselerator for LNMP V0.8  ,  Written by Licess \n"
printf "=======================================================================\n"
printf "LNMP is a tool to auto-compile & install Nginx+MySQL+PHP on Linux \n"
printf "This script is a tool to install eAccelerator for lnmp \n"
printf "\n"
printf "For more information please visit http://www.lnmp.org \n"
printf "=======================================================================\n"