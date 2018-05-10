#!/bin/bash

clear
echo "========================================================================="
echo "LNMP v0.2 for Debian/Ubuntu VPS ,  Written by Licess "
echo "========================================================================="
echo "A tool to auto-compile & install Nginx+MySQL+PHP on Linux "
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

apt-get update -y
apt-get install -y build-essential
apt-get install -y gcc
apt-get install -y g++
apt-get install -y ssh
apt-get install -y automake
apt-get install -y autoconf
apt-get install -y make
apt-get install -y re2c
apt-get install -y wget
apt-get install -y cron
apt-get install -y bzip2
apt-get install -y rcconf
apt-get install -y flex
apt-get install -y vim
apt-get install -y bison
apt-get install -y m4
apt-get install -y awk
apt-get install -y make
apt-get install -y cpp
apt-get install -y binutils
apt-get install -y unzip
apt-get install -y tar
apt-get install -y libncurses5
apt-get install -y libncurses5-dev
apt-get install -y libtool
apt-get install -y libpcre3
apt-get install -y libpcrecpp0
apt-get install -y libssl-dev
apt-get install -y zlibc
apt-get install -y openssl
apt-get install -y libxml2-dev
apt-get install -y libltdl3-dev
apt-get install -y libmcrypt-dev
apt-get install -y libmysqlclient15-dev
apt-get install -y libbz2-dev
apt-get install -y libpcre3-dev
apt-get install -y libssl-dev
apt-get install -y zlib1g-dev
apt-get install -y libpng3
apt-get install -y libfreetype6
apt-get install -y libfreetype6-dev
apt-get install -y libjpeg62 libjpeg62-dev
apt-get install -y libpng12-0 libpng12-dev
apt-get install -y libfreetype6 libfreetype6-dev
apt-get install -y curl
apt-get install -y libcurl3
apt-get install -y libcurl3-dev
apt-get install -y libcurl4-openssl-dev
apt-get install -y libmhash2
apt-get install -y libmhash-dev
apt-get install -y libpq-dev
apt-get install -y libpq5
apt-get install -y locales

if [ -s php-5.2.10.tar.gz ]; then
  echo "php-5.2.10.tar.gz [found]"
  else
  echo "Error: php-5.2.10.tar.gz not found!!!download now......"
  wget -c http://soft.vpser.net/web/php/php-5.2.10.tar.gz
fi

if [ -s php-5.2.10-fpm-0.5.13.diff.gz ]; then
  echo "php-5.2.10-fpm-0.5.13.diff.gz [found]"
  else
  echo "Error: php-5.2.10-fpm-0.5.13.diff.gz not found!!!download now......"
  wget -c http://soft.vpser.net/web/phpfpm/php-5.2.10-fpm-0.5.13.diff.gz
fi

if [ -s nginx-0.7.61.tar.gz ]; then
  echo "nginx-0.7.61.tar.gz [found]"
  else
  echo "Error: nginx-0.7.61.tar.gz not found!!!download now......"
  wget -c http://soft.vpser.net/web/nginx/nginx-0.7.61.tar.gz
fi

#if [ -s mysql-5.1.35.tar.gz ]; then
#  echo "mysql-5.1.35.tar.gz [found]"
#  else
#  echo "Error: mysql-5.1.35.tar.gz not found!!!download now......"
#  wget -c http://soft.vpser.net/datebase/mysql/mysql-5.1.35.tar.gz
#fi

if [ -s zend.tar.gz ]; then
  echo "zend.tar.gz [found]"
  else
  echo "Error: zend.tar.gz not found!!!download now......"
  wget -c http://soft.vpser.net/web/zend/zend.tar.gz
fi

if [ -s libiconv-1.13.tar.gz ]; then
  echo "libiconv-1.13.tar.gz [found]"
  else
  echo "Error: libiconv-1.13.tar.gz not found!!!download now......"
  wget -c http://soft.vpser.net/web/libiconv/libiconv-1.13.tar.gz
fi

if [ -s phpmyadmin.tar.gz ]; then
  echo "phpmyadmin.tar.gz [found]"
  else
  echo "Error: phpmyadmin.tar.gz not found!!!download now......"
  wget -c http://soft.vpser.net/datebase/phpmyadmin/phpmyadmin.tar.gz
fi

tar zxvf libiconv-1.13.tar.gz
cd libiconv-1.13/
./configure --prefix=/usr/local/libiconv
make && make install
cd ../

# mysql
apt-get install -y mysql-server

# php
tar zxvf php-5.2.10.tar.gz
gzip -cd php-5.2.10-fpm-0.5.13.diff.gz | patch -d php-5.2.10 -p1
cd php-5.2.10/
./configure --prefix=/usr/local/php --with-config-file-path=/usr/local/php/etc --with-mysql --with-mysqli --with-iconv-dir=/usr/local/libiconv --with-freetype-dir --with-jpeg-dir --with-png-dir --with-zlib --with-libxml-dir=/usr --enable-xml --disable-rpath --enable-discard-path --enable-safe-mode --enable-bcmath --enable-shmop --enable-sysvsem --enable-inline-optimization --with-curl --with-curlwrappers --enable-mbregex --enable-fastcgi --enable-fpm --enable-force-cgi-redirect --enable-mbstring --with-mcrypt --with-gd --enable-gd-native-ttf --with-openssl --with-mhash --enable-pcntl --enable-sockets --with-xmlrpc --enable-zip --enable-soap --without-pear
make && make install
cp php.ini-dist /usr/local/php/etc/php.ini
strip /usr/local/php/bin/php-cgi
cd ../

# php extensions
tar zxvf zend.tar.gz
cp -R zend /usr/local/zend
sed -i 's#output_buffering = Off#output_buffering = On#' /usr/local/php/etc/php.ini

cat >>/usr/local/php/etc/php.ini<<EOF
[Zend]
zend_extension_manager.optimizer=/usr/local/zend/lib/Optimizer-3.3.3
zend_extension_manager.optimizer_ts=/usr/local/zend/lib/Optimizer_TS-3.3.3
zend_optimizer.version=3.3.3
zend_extension=/usr/local/zend/lib/ZendExtensionManager.so
zend_extension_ts=/usr/local/zend/lib/ZendExtensionManager_TS.so
EOF

groupadd www
useradd -g www www
mkdir -p /home/wwwroot
chmod +w /home/wwwroot
mkdir -p /home/wwwroot/logs
chmod 777 /home/wwwroot/logs
touch /home/wwwroot/logs/nginx_error.log

chown -R www:www /home/wwwroot
rm -f /usr/local/php/etc/php-fpm.conf
cp conf/php-fpm.conf /usr/local/php/etc/php-fpm.conf

echo "ulimit -SHn 51200" >/root/run.sh
echo "/usr/local/php/sbin/php-fpm start" >>/root/run.sh

# nginx

tar zxf nginx-0.7.61.tar.gz
cd nginx-0.7.61/
./configure --user=www --group=www --prefix=/usr/local/nginx --with-http_stub_status_module --with-http_ssl_module --with-http_gzip_static_module
make
make install
cd ../

rm -f /usr/local/nginx/conf/nginx.conf
cp conf/nginx.conf /usr/local/nginx/conf/nginx.conf
sed -i 's/www.lnmp.org/'$domain'/g' /usr/local/nginx/conf/nginx.conf

rm -f /usr/local/nginx/conf/fcgi.conf
cp conf/fcgi.conf /usr/local/nginx/conf/fcgi.conf

echo "/usr/local/nginx/sbin/nginx" >>/root/run.sh
chmod 777 /root/run.sh
/usr/local/mysql/bin/mysqld_safe --defaults-file=/usr/local/mysql/my.cnf &
/root/run.sh

#phpinfo
cat >/home/wwwroot/phpinfo.php<<eof
<?
phpinfo();
?>
eof

#phpmyadmin
tar zxvf phpmyadmin.tar.gz
mv phpmyadmin /home/wwwroot/

clear
echo "========================================================================="
echo "LNMP v0.2 for Debian/Ubuntu VPS , Written by Licess "
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