#!/bin/bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

# Check if user is root
if [ $(id -u) != "0" ]; then
    echo "Error: You must be root to run this script, please use root to install lnmp"
    exit 1
fi

clear
echo "========================================================================="
echo "LNMP V0.5 for CentOS/RadHat Linux VPS  Written by Licess"
echo "========================================================================="
echo "A tool to auto-compile & install Nginx+MySQL+PHP on Linux "
echo ""
echo "For more information please visit http://www.lnmp.org/"
echo "========================================================================="
cur_dir=$(pwd)

if [ "$1" != "--help" ]; then


#set main domain name

	domain="www.lnmp.org"
	echo "Please input domain:"
	read -p "(Default domain: www.lnmp.org):" domain
	if [ "$domain" = "" ]; then
		domain="www.lnmp.org"
	fi
	echo "==========================="

	echo domain="$domain"

	echo "==========================="

#set mysql root password

	echo "==========================="

	mysqlrootpwd="root"
	echo "Please input the root password of mysql:"
	read -p "(Default password: root):" mysqlrootpwd
	if [ "$mysqlrootpwd" = "" ]; then
		mysqlrootpwd="root"
	fi
	echo "==========================="

	echo mysqlrootpwd="$mysqlrootpwd"

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

rpm -qa|grep  httpd
rpm -e httpd
rpm -qa|grep mysql
rpm -e mysql
rpm -qa|grep php
rpm -e php

yum -y remove httpd
yum -y remove php
yum -y remove mysql-server mysql
yum -y remove php-mysql

yum -y install yum-fastestmirror
yum -y remove httpd
yum -y update

#Synchronization time
rm -rf /etc/localtime
ln -s /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

yum install -y ntp
ntpdate -d cn.pool.ntp.org
date

#Disable SeLinux
sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config

yum -y install patch make gcc gcc-c++ gcc-g77 flex bison file
yum -y install libtool libtool-libs autoconf kernel-devel
yum -y install libjpeg libjpeg-devel libpng libpng-devel libpng10 libpng10-devel gd gd-devel
yum -y install freetype freetype-devel libxml2 libxml2-devel zlib zlib-devel
yum -y install glib2 glib2-devel bzip2 bzip2-devel libevent libevent-devel
yum -y install ncurses ncurses-devel curl curl-devel e2fsprogs
yum -y install e2fsprogs-devel krb5 krb5-devel libidn libidn-devel
yum -y install openssl openssl-devel vim-minimal nano sendmail
yum -y install fonts-chinese gettext gettext-devel
yum -y install ncurses-devel
yum -y install gmp-devel pspell-devel
yum -y install unzip

echo "============================check files=================================="
if [ -s php-5.2.14.tar.gz ]; then
  echo "php-5.2.14.tar.gz [found]"
  else
  echo "Error: php-5.2.14.tar.gz not found!!!download now......"
  wget -c http://soft.vpser.net/web/php/php-5.2.14.tar.gz
fi

if [ -s php-5.2.14-fpm-0.5.14.diff.gz ]; then
  echo "php-5.2.14-fpm-0.5.14.diff.gz [found]"
  else
  echo "Error: php-5.2.14-fpm-0.5.14.diff.gz not found!!!download now......"
  wget -c http://soft.vpser.net/web/phpfpm/php-5.2.14-fpm-0.5.14.diff.gz
fi

if [ -s PDO_MYSQL-1.0.2.tgz ]; then
  echo "PDO_MYSQL-1.0.2.tgz [found]"
  else
  echo "Error: PDO_MYSQL-1.0.2.tgz not found!!!download now......"
  wget -c http://soft.vpser.net/web/pdo/PDO_MYSQL-1.0.2.tgz
fi

if [ -s memcache-2.2.5.tgz ]; then
  echo "memcache-2.2.5.tgz [found]"
  else
  echo "Error: memcache-2.2.5.tgz not found!!!download now......"
  wget -c http://soft.vpser.net/web/memcache/memcache-2.2.5.tgz
fi

if [ -s pcre-8.10.tar.gz ]; then
  echo "pcre-8.10.tar.gz [found]"
  else
  echo "Error: pcre-8.10.tar.gz not found!!!download now......"
wget -c http://soft.vpser.net/web/pcre/pcre-8.10.tar.gz
fi

if [ -s nginx-0.7.67.tar.gz ]; then
  echo "nginx-0.7.67.tar.gz [found]"
  else
  echo "Error: nginx-0.7.67.tar.gz not found!!!download now......"
  wget -c http://soft.vpser.net/web/nginx/nginx-0.7.67.tar.gz
fi

if [ -s mysql-5.1.48.tar.gz ]; then
  echo "mysql-5.1.48.tar.gz [found]"
  else
  echo "Error: mysql-5.1.48.tar.gz not found!!!download now......"
  wget -c http://soft.vpser.net/datebase/mysql/mysql-5.1.48.tar.gz
fi

if [ -s libiconv-1.13.tar.gz ]; then
  echo "libiconv-1.13.tar.gz [found]"
  else
  echo "Error: libiconv-1.13.tar.gz not found!!!download now......"
  wget -c http://soft.vpser.net/web/libiconv/libiconv-1.13.tar.gz
fi

if [ -s libmcrypt-2.5.8.tar.gz ]; then
  echo "libmcrypt-2.5.8.tar.gz [found]"
  else
  echo "Error: libmcrypt-2.5.8.tar.gz not found!!!download now......"
  wget -c  http://soft.vpser.net/web/libmcrypt/libmcrypt-2.5.8.tar.gz
fi

if [ -s mhash-0.9.9.9.tar.gz ]; then
  echo "mhash-0.9.9.9.tar.gz [found]"
  else
  echo "Error: mhash-0.9.9.9.tar.gz not found!!!download now......"
  wget -c http://soft.vpser.net/web/mhash/mhash-0.9.9.9.tar.gz
fi

if [ -s mcrypt-2.6.8.tar.gz ]; then
  echo "mcrypt-2.6.8.tar.gz [found]"
  else
  echo "Error: mcrypt-2.6.8.tar.gz not found!!!download now......"
  wget -c http://soft.vpser.net/web/mcrypt/mcrypt-2.6.8.tar.gz
fi

if [ -s phpmyadmin.tar.gz ]; then
  echo "phpmyadmin.tar.gz [found]"
  else
  echo "Error: phpmyadmin.tar.gz not found!!!download now......"
  wget -c http://soft.vpser.net/datebase/phpmyadmin/phpmyadmin.tar.gz
fi

if [ -s p.tar.gz ]; then
  echo "p.tar.gz [found]"
  else
  echo "Error: p.tar.gz not found!!!download now......"
  wget -c http://soft.vpser.net/prober/p.tar.gz
fi

if [ -s suhosin-patch-5.2.14-0.9.7.patch.gz ]; then
  echo "suhosin-patch-5.2.14-0.9.7.patch.gz [found]"
  else
  echo "Error: suhosin-patch-5.2.14-0.9.7.patch.gz not found!!!download now......"
  wget -c http://soft.vpser.net/web/suhosin/suhosin-patch-5.2.14-0.9.7.patch.gz
fi
echo "============================check files=================================="

cd $cur_dir
tar zxvf libiconv-1.13.tar.gz
cd libiconv-1.13/
./configure --prefix=/usr/local
make && make install
cd ../

cd $cur_dir
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
tar zxvf mcrypt-2.6.8.tar.gz
cd mcrypt-2.6.8/
./configure
make && make install
cd ../

echo "============================mysql install=================================="
cd $cur_dir
tar -zxvf mysql-5.1.48.tar.gz
cd mysql-5.1.48/
./configure --prefix=/usr/local/mysql --with-extra-charsets=all --enable-thread-safe-client --enable-assembler --with-charset=utf8 --enable-thread-safe-client --with-extra-charsets=all --with-big-tables --with-readline --with-ssl --with-embedded-server --enable-local-infile
make && make install
cd ../

groupadd mysql
useradd -g mysql mysql
cp /usr/local/mysql/share/mysql/my-medium.cnf /etc/my.cnf
sed -i 's/skip-locking/skip-external-locking/g' /etc/my.cnf
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

/usr/local/mysql/bin/mysqladmin -u root password $mysqlrootpwd

/etc/init.d/mysql restart
/etc/init.d/mysql stop
chkconfig mysql-ndb off
chkconfig mysql-ndb-mgm off
echo "============================mysql intall completed========================="

echo "============================php+eaccelerator install======================"
cd $cur_dir
tar zxvf php-5.2.14.tar.gz
gzip -d ./suhosin-patch-5.2.14-0.9.7.patch.gz 
gzip -cd php-5.2.14-fpm-0.5.14.diff.gz | patch -d php-5.2.14 -p1
cd php-5.2.14/
patch -p 1 -i ../suhosin-patch-5.2.14-0.9.7.patch
./buildconf --force
./configure --prefix=/usr/local/php --with-config-file-path=/usr/local/php/etc --with-mysql=/usr/local/mysql --with-mysqli=/usr/local/mysql/bin/mysql_config --with-iconv-dir --with-freetype-dir --with-jpeg-dir --with-png-dir --with-zlib --with-libxml-dir=/usr --enable-xml --disable-rpath --enable-discard-path --enable-magic-quotes --enable-safe-mode --enable-bcmath --enable-shmop --enable-sysvsem --enable-inline-optimization --with-curl --with-curlwrappers --enable-mbregex --enable-fastcgi --enable-fpm --enable-force-cgi-redirect --enable-mbstring --with-mcrypt --enable-ftp --with-gd --enable-gd-native-ttf --with-openssl --with-mhash --enable-pcntl --enable-sockets --with-xmlrpc --enable-zip --enable-soap --without-pear --with-gettext --with-mime-magic --enable-suhosin
make ZEND_EXTRA_LIBS='-liconv'
make install
cp php.ini-dist /usr/local/php/etc/php.ini
cd ../

ln -s /usr/local/php/bin/php /usr/bin/php

cd $cur_dir
tar zxvf memcache-2.2.5.tgz
cd memcache-2.2.5/
/usr/local/php/bin/phpize
./configure --with-php-config=/usr/local/php/bin/php-config
make && make install
cd ../

tar zxvf PDO_MYSQL-1.0.2.tgz
cd PDO_MYSQL-1.0.2/
/usr/local/php/bin/phpize
./configure --with-php-config=/usr/local/php/bin/php-config --with-pdo-mysql=/usr/local/mysql
make
make install
cd ../

sed -i 's#extension_dir = "./"#extension_dir = "/usr/local/php/lib/php/extensions/no-debug-non-zts-20060613/"\nextension = "memcache.so"\nextension = "pdo_mysql.so"\n#' /usr/local/php/etc/php.ini
sed -i 's#output_buffering = Off#output_buffering = On#' /usr/local/php/etc/php.ini
sed -i 's/post_max_size = 8M/post_max_size = 50M/g' /usr/local/php/etc/php.ini
sed -i 's/upload_max_filesize = 2M/upload_max_filesize = 50M/g' /usr/local/php/etc/php.ini
sed -i 's/;date.timezone =/date.timezone = PRC/g' /usr/local/php/etc/php.ini
sed -i 's/; cgi.fix_pathinfo=0/cgi.fix_pathinfo=0/g' /usr/local/php/etc/php.ini
sed -i 's/max_execution_time = 30/max_execution_time = 300/g' /usr/local/php/etc/php.ini

if [ `getconf WORD_BIT` = '32' ] && [ `getconf LONG_BIT` = '64' ] ; then
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
;eaccelerator

;ionCube

[Zend Optimizer] 
zend_optimizer.optimization_level=1 
zend_extension="/usr/local/zend/ZendOptimizer.so" 
EOF

groupadd www
useradd -g www www
mkdir -p /home/wwwroot
chmod +w /home/wwwroot
mkdir -p /home/wwwlogs
chmod 777 /home/wwwlogs

chown -R www:www /home/wwwroot
rm -f /usr/local/php/etc/php-fpm.conf
cp conf/php-fpm.conf /usr/local/php/etc/php-fpm.conf

echo "============================php+eaccelerator install completed======================"

echo "============================nginx install================================="
cd $cur_dir
tar zxvf pcre-8.10.tar.gz
cd pcre-8.10/
./configure
make && make install
cd ../

tar zxvf nginx-0.7.67.tar.gz
cd nginx-0.7.67/
./configure --user=www --group=www --prefix=/usr/local/nginx --with-http_stub_status_module --with-http_ssl_module --with-http_gzip_static_module --with-ipv6
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
cp conf/discuzx.conf /usr/local/nginx/conf/discuzx.conf
cp conf/none.conf /usr/local/nginx/conf/none.conf
sed -i 's/www.lnmp.org/'$domain'/g' /usr/local/nginx/conf/nginx.conf

rm -f /usr/local/nginx/conf/fcgi.conf
cp conf/fcgi.conf /usr/local/nginx/conf/fcgi.conf

/etc/init.d/mysql start

cd $cur_dir
cp lnmp /root/lnmp
chmod +x /root/lnmp
cp vhost.sh /root/vhost.sh
chmod +x /root/vhost.sh
/root/lnmp start
echo "============================nginx install completed================================="

cat >/home/wwwroot/phpinfo.php<<eof
<?
phpinfo();
?>
eof

cd $cur_dir
tar zxvf p.tar.gz
cp p.php /home/wwwroot/p.php

cp conf/index.html /home/wwwroot/index.html
echo "============================phpMyAdmin install================================="
#phpmyadmin
tar zxvf phpmyadmin.tar.gz
mv phpmyadmin /home/wwwroot/
chmod 755 -R /home/wwwroot/phpmyadmin/
chown www:www -R /home/wwwroot/phpmyadmin/
echo "============================phpMyAdmin install completed================================="

echo "============================add nginx and php-fpm on startup============================"
echo "ulimit -SHn 51200" >>/etc/rc.local
echo "/usr/local/php/sbin/php-fpm start" >>/etc/rc.local
echo "/usr/local/nginx/sbin/nginx" >>/etc/rc.local
echo "===========================add nginx and php-fpm on startup completed===================="

echo "===================================== Check install ==================================="
clear
if [ -s /usr/local/nginx ]; then
  echo "/usr/local/nginx [found]"
  else
  echo "Error: /usr/local/nginx not found!!!"
fi

if [ -s /usr/local/php ]; then
  echo "/usr/local/php [found]"
  else
  echo "Error: /usr/local/php not found!!!"
fi

if [ -s /usr/local/mysql ]; then
  echo "/usr/local/mysql [found]"
  else
  echo "Error: /usr/local/mysql not found!!!"
fi

echo "========================== Check install ================================"

echo "Install lnmp 0.5 completed! enjoy it."
echo "========================================================================="
echo "LNMP V0.5 for CentOS/RadHat Linux VPS  Written by Licess "
echo "========================================================================="
echo ""
echo "For more information please visit http://www.lnmp.org/"
echo ""
echo "lnmp status manage: /root/lnmp {start|stop|reload|restart|kill|status}"
echo "default mysql root password:$mysqlrootpwd"
echo "phpinfo : http://$domain/phpinfo.php"
echo "phpMyAdmin : http://$domain/phpmyadmin/"
echo "Prober : http://$domain/p.php"
echo "Add VirtualHost : /root/vhost.sh"
echo ""
echo "The path of some dirs:"
echo "mysql dir:   /usr/local/mysql"
echo "php dir:     /usr/local/php"
echo "nginx dir:   /usr/local/nginx"
echo "web dir :     /home/wwwroot"
echo ""
echo "========================================================================="
fi
/root/lnmp status
netstat -ntl