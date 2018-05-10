#!/bin/bash

# Check if user is root
if [ $(id -u) != "0" ]; then
    echo "Error: You must be root to run this script, please use root to install lnmp"
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

yum -y remove httpd
yum -y update
yum -y install patch make gcc gcc-c++ gcc-g77 flex bison
yum -y install libtool libtool-libs autoconf kernel-devel
yum -y install libjpeg libjpeg-devel libpng libpng-devel
yum -y install freetype freetype-devel libxml2 libxml2-devel zlib zlib-devel
yum -y install glib2 glib2-devel bzip2
yum -y install bzip2-devel ncurses ncurses-devel curl curl-devel e2fsprogs
yum -y install e2fsprogs-devel krb5 krb5-devel libidn libidn-devel
yum -y install openssl openssl-devel vim-minimal sendmail
yum -y install fonts-chinese scim-chewing scim-pinyin scim-tables-chinese

cd $cur_dir
wget -c http://soft.vpser.net/web/libiconv/libiconv-1.13.tar.gz
tar zxvf libiconv-1.13.tar.gz
cd libiconv-1.13/
./configure --prefix=/usr/local
make && make install
cd ../

cd $cur_dir
wget -c  http://soft.vpser.net/web/libmcrypt/libmcrypt-2.5.8.tar.gz
tar zxvf libmcrypt-2.5.8.tar.gz
cd libmcrypt-2.5.8/
./configure
make && make install
/sbin/ldconfig
cd libltdl/
./configure --enable-ltdl-install
make && make install
cd ../../

cd $cur_dir
wget -c http://soft.vpser.net/web/mhash/mhash-0.9.9.9.tar.gz
tar zxvf mhash-0.9.9.9.tar.gz
cd mhash-0.9.9.9/
./configure
make && make install
cd ../

ln -s /usr/local/lib/libmcrypt.la /usr/lib/libmcrypt.la
ln -s /usr/local/lib/libmcrypt.so /usr/lib/libmcrypt.so
ln -s /usr/local/lib/libmcrypt.so.4 /usr/lib/libmcrypt.so.4
ln -s /usr/local/lib/libmcrypt.so.4.4.8 /usr/lib/libmcrypt.so.4.4.8
ln -s /usr/local/lib/libmhash.a /usr/lib/libmhash.a
ln -s /usr/local/lib/libmhash.la /usr/lib/libmhash.la
ln -s /usr/local/lib/libmhash.so /usr/lib/libmhash.so
ln -s /usr/local/lib/libmhash.so.2 /usr/lib/libmhash.so.2
ln -s /usr/local/lib/libmhash.so.2.0.1 /usr/lib/libmhash.so.2.0.1

cd $cur_dir
wget -c http://soft.vpser.net/web/mcrypt/mcrypt-2.6.8.tar.gz
tar zxvf mcrypt-2.6.8.tar.gz
cd mcrypt-2.6.8/
./configure
make && make install
cd ../

echo "============================mysql install=================================="
cd $cur_dir
wget -c http://soft.vpser.net/datebase/mysql/mysql-5.1.35.tar.gz
tar -zxvf mysql-5.1.35.tar.gz
cd mysql-5.1.35
./configure --prefix=/usr/local/mysql --enable-assembler --with-charset=utf8 --enable-thread-safe-client --with-extra-charsets=all --with-big-tables --with-readline --with-ssl --with-embedded-server --enable-local-infile
make && make install
cd ../

groupadd mysql
useradd -g mysql mysql
cp /usr/local/mysql/share/mysql/my-medium.cnf /etc/my.cnf
/usr/local/mysql/bin/mysql_install_db --user=mysql
chown -R mysql /usr/local/mysql/var
chgrp -R mysql /usr/local/mysql/.
cp /usr/local/mysql/share/mysql/mysql.server /etc/init.d/mysql
chmod 755 /etc/init.d/mysql
chkconfig --level 345 mysql on
echo "/usr/local/mysql/lib/mysql" >> /etc/ld.so.conf
echo "/usr/local/lib" >>/etc/ld.so.conf
ldconfig
ln -s /usr/local/mysql/lib/mysql /usr/lib/mysql
ln -s /usr/local/mysql/include/mysql /usr/include/mysql
/etc/init.d/mysql start
/usr/local/mysql/bin/mysqladmin -u root password root
/etc/init.d/mysql restart
/etc/init.d/mysql stop
chkconfig mysql-ndb off
chkconfig mysql-ndb-mgm off
echo "============================mysql intall finished========================="

echo "============================php+eaccelerator install======================"
cd $cur_dir
wget -c http://soft.vpser.net/web/php/php-5.2.10.tar.gz
wget -c http://soft.vpser.net/web/phpfpm/php-5.2.10-fpm-0.5.11.diff.gz
tar zxvf php-5.2.10.tar.gz
gzip -cd php-5.2.10-fpm-0.5.11.diff.gz | patch -d php-5.2.10 -p1
cd php-5.2.10/
./configure --prefix=/usr/local/php --with-config-file-path=/usr/local/php/etc --with-mysql=/usr/local/mysql --with-mysqli=/usr/local/mysql/bin/mysql_config --with-iconv-dir=/usr/local --with-freetype-dir --with-jpeg-dir --with-png-dir --with-zlib --with-libxml-dir=/usr --enable-xml --disable-rpath --enable-discard-path --enable-safe-mode --enable-bcmath --enable-shmop --enable-sysvsem --enable-inline-optimization --with-curl --with-curlwrappers --enable-mbregex --enable-fastcgi --enable-fpm --enable-force-cgi-redirect --enable-mbstring --with-mcrypt --with-gd --enable-gd-native-ttf --with-openssl --with-mhash --enable-pcntl --enable-sockets --with-xmlrpc --enable-zip --enable-ftp --without-pear --with-mime-magic=/usr/share/file/magic.mime
make ZEND_EXTRA_LIBS='-liconv'
make install
cp php.ini-dist /usr/local/php/etc/php.ini
cd ../

cd $cur_dir
wget -c http://soft.vpser.net/web/memcache/memcache-2.2.5.tgz
tar zxvf memcache-2.2.5.tgz
cd memcache-2.2.5/
/usr/local/php/bin/phpize
./configure --with-php-config=/usr/local/php/bin/php-config
make && make install
cd ../

sed -i 's#extension_dir = "./"#extension_dir = "/usr/local/php/lib/php/extensions/no-debug-non-zts-20060613/"\nextension = "memcache.so"\n#' /usr/local/php/etc/php.ini
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

chown -R www:www /home/wwwroot
rm -f /usr/local/php/etc/php-fpm.conf
cp conf/php-fpm.conf /usr/local/php/etc/php-fpm.conf

echo "ulimit -SHn 51200" >/root/run.sh
echo "/usr/local/php/sbin/php-fpm start" >>/root/run.sh

echo "============================php+eaccelerator install finished======================"

echo "============================nginx install================================="
cd $cur_dir
wget -c http://soft.vpser.net/web/pcre/pcre-7.9.tar.gz
tar zxvf pcre-7.9.tar.gz
cd pcre-7.9/
./configure
make && make install
cd ../

wget -c http://soft.vpser.net/web/nginx/nginx-0.7.63.tar.gz
tar zxvf nginx-0.7.63.tar.gz
cd nginx-0.7.63/
./configure --user=www --group=www --prefix=/usr/local/nginx --with-http_stub_status_module --with-http_ssl_module
make && make install
cd ../

rm -f /usr/local/nginx/conf/nginx.conf
cd $cur_dir
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
echo "============================nginx install finished================================="

cat >/home/wwwroot/phpinfo.php<<eof
<?
phpinfo();
?>
eof
wget -c http://soft.vpser.net/prober/prober2.tar.gz
tar zxvf prober2.tar.gz
mv prober2.php /home/wwwroot/p.php
echo "============================phpMyAdmin install================================="
wget -c http://soft.vpser.net/datebase/phpmyadmin/phpmyadmin.tar.gz
#phpmyadmin
tar zxvf phpmyadmin.tar.gz
mv phpmyadmin /home/wwwroot/
echo "============================phpMyAdmin install finished================================="

echo "============================add nginx and php-fpm on startup============================"
echo "ulimit -SHn 51200" >>/etc/rc.local
echo "/usr/local/php/sbin/php-fpm start" >>/etc/rc.local
echo "/usr/local/nginx/sbin/nginx" >>/etc/rc.local
echo "===========================add nginx and php-fpm on startup finished===================="

#set timezone
cp -f /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

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
fi