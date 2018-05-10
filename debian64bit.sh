#!/bin/bash

# Check if user is root
if [ $(id -u) != "0" ]; then
    echo "Error: You must be root to run this script, please use root to install lnmp"
    exit 1
fi

clear
echo "========================================================================="
echo "LNMP V0.3 for Debian/Ubuntu VPS 64bit ,  Written by Licess "
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
cur_dir=$(pwd)

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

apt-get remove -y remove httpd
killall apache2
apt-get update -y --force-yes

apt-get install -y --force-yes build-essential

apt-get install -y autoconf

apt-get install -y --force-yes gcc g++ ssh automake autoconf make re2c wget cron bzip2 rcconf flex vim bison m4 awk cpp binutils libncurses5 unzip tar libncurses5 libncurses5-dev

apt-get install -y --force-yes libtool libpcre3 libpcrecpp0 libssl-dev zlibc openssl libxml2-dev libltdl3-dev libpcre3 libpcrecpp0 libssl-dev zlibc openssl libxml2-dev libltdl3-dev

apt-get install -y --force-yes libmcrypt-dev libmysqlclient15-dev libbz2-dev libpcre3-dev libssl-dev zlib1g-dev zlib1g-dev libfreetype6 libfreetype6-dev

apt-get install -y --force-yes libmysqlclient15-dev libbz2-dev libpcre3-dev libssl-dev zlib1g-dev libpng3 libfreetype6 libfreetype6-dev

apt-get install -y --force-yes libjpeg62 libjpeg62-dev libpng12-0 libpng12-dev curl libcurl3 libcurl3-dev libcurl4-openssl-dev libmhash2 libmhash-dev

apt-get install -y --force-yes libpng12-0 libpng12-dev libfreetype6 libfreetype6-dev curl libcurl3 libcurl3-dev libcurl4-openssl-dev libmhash2 libmhash-dev libpq-dev libpq5

apt-get install -y --force-yes libfreetype6 libfreetype6-dev

apt-get install -y --force-yes locales

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

if [ -s nginx-0.7.63.tar.gz ]; then
  echo "nginx-0.7.63.tar.gz [found]"
  else
  echo "Error: nginx-0.7.63.tar.gz not found!!!download now......"
  wget -c http://soft.vpser.net/web/nginx/nginx-0.7.63.tar.gz
fi

#if [ -s mysql-5.1.35.tar.gz ]; then
#  echo "mysql-5.1.35.tar.gz [found]"
#  else
#  echo "Error: mysql-5.1.35.tar.gz not found!!!download now......"
#  wget -c http://soft.vpser.net/datebase/mysql/mysql-5.1.35.tar.gz
#fi

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

if [ -s prober2.tar.gz ]; then
  echo "prober2.tar.gz [found]"
  else
  echo "Error: prober2.tar.gz not found!!!download now......"
  wget -c http://soft.vpser.net/prober/prober2.tar.gz
fi

cd $cur_dir
tar zxvf libiconv-1.13.tar.gz
cd libiconv-1.13/
./configure --prefix=/usr/local/libiconv
make && make install
cd ../

# mysql
apt-get install mysql-server
update-rc.d -f mysql-ndb remove
update-rc.d -f mysql-ndb-mgm remove

# php
tar zxvf php-5.2.10.tar.gz
gzip -cd php-5.2.10-fpm-0.5.13.diff.gz | patch -d php-5.2.10 -p1
cd php-5.2.10/
./configure --prefix=/usr/local/php --with-config-file-path=/usr/local/php/etc --with-mysql --with-mysqli --with-iconv-dir=/usr/local/libiconv --with-freetype-dir --with-jpeg-dir --with-png-dir --with-zlib --with-libxml-dir=/usr --enable-xml --disable-rpath --enable-discard-path --enable-safe-mode --enable-bcmath --enable-shmop --enable-sysvsem --enable-inline-optimization --with-curl --with-curlwrappers --enable-mbregex --enable-fastcgi --enable-fpm --enable-force-cgi-redirect --enable-mbstring --with-mcrypt --with-gd --enable-gd-native-ttf --with-openssl --with-mhash --enable-pcntl --enable-sockets --with-xmlrpc --enable-zip --enable-soap --without-pear --with-mime-magic=/usr/share/file/magic.mime
make && make install
cp php.ini-dist /usr/local/php/etc/php.ini
strip /usr/local/php/bin/php-cgi
cd ../

# php extensions
sed -i 's#output_buffering = Off#output_buffering = On#' /usr/local/php/etc/php.ini
sed -i 's/post_max_size = 8M/post_max_size = 50M/g' /usr/local/php/etc/php.ini
sed -i 's/upload_max_filesize = 2M/upload_max_filesize = 50M/g' /usr/local/php/etc/php.ini
sed -i 's/;date.timezone =/date.timezone = PRC/g' /usr/local/php/etc/php.ini

if [ `uname -m` = 'x86_64' ]; then
        wget -c http://soft.vpser.net/web/zend/ZendOptimizer-3.3.9-linux-glibc23-x86_64.tar.gz
        tar zxvf ZendOptimizer-3.3.9-linux-glibc23-x86_64.tar.gz
	mkdir -p /usr/local/zend/
	cp ZendOptimizer-3.3.9-linux-glibc23-x86_64/data/5_2_x_comp/ZendOptimizer.so /usr/local/zend/
else
        wget -c http://soft.vpser.net/web/zend/ZendOptimizer-3.3.9-linux-glibc23-i386.tar.gz
	tar zxvf ZendOptimizer-3.3.9-linux-glibc23-i386.tar.gz
	mkdir -p /usr/local/zend/
	cp ZendOptimizer-3.3.9-linux-glibc23-i386/data/5_2_x_comp/ZendOptimizer.so /usr/local/zend/
fi

cat >>/usr/local/php/etc/php.ini<<EOF
[Zend Optimizer] 
zend_optimizer.optimization_level=1 
zend_extension="/usr/local/zend/ZendOptimizer.so" 
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
cd $cur_dir
tar zxf nginx-0.7.63.tar.gz
cd nginx-0.7.63/
./configure --user=www --group=www --prefix=/usr/local/nginx --with-http_stub_status_module --with-http_ssl_module --with-http_gzip_static_module
make
make install
cd ../

cd $cur_dir
rm -f /usr/local/nginx/conf/nginx.conf
cp conf/nginx.conf /usr/local/nginx/conf/nginx.conf
cp conf/dabr.conf /usr/local/nginx/conf/dabr.conf
cp conf/discuz.conf /usr/local/nginx/conf/discuz.conf
cp conf/sablog.conf /usr/local/nginx/conf/sablog.conf
cp conf/typecho.conf /usr/local/nginx/conf/typecho.conf
cp conf/wordpress.conf /usr/local/nginx/conf/wordpress.conf
sed -i 's/www.lnmp.org/'$domain'/g' /usr/local/nginx/conf/nginx.conf

rm -f /usr/local/nginx/conf/fcgi.conf
cp conf/fcgi.conf /usr/local/nginx/conf/fcgi.conf

echo "/usr/local/nginx/sbin/nginx" >>/root/run.sh
chmod 777 /root/run.sh
/etc/init.d/mysql start
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

#prober
tar zxvf prober2.tar.gz
mv prober2.php /home/wwwroot/p.php

#start up
cp /root/run.sh /etc/init.d/nginx.sh
update-rc.d nginx.sh defaults

clear
echo "========================================================================="
echo "LNMP V0.3 for Debian/Ubuntu VPS 64bit , Written by Licess "
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
netstat -ntl