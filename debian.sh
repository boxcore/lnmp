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
echo "LNMP V0.4 for Debian/Ubuntu VPS ,  Written by Licess "
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
	echo "domain=$domain"
	echo "==========================="

#set area

	area="america"
	echo "Where are your servers located? asia,america,europe,oceania or africa "
	read -p "(Default area: america):" area
	if [ "$area" = "" ]; then
		area="america"
	fi
	echo "==========================="
	echo  "area=$area"
	echo "==========================="

#set mysql root password

	mysqlrootpwd="root"
	echo "Please input the root password of mysql:"
	read -p "(Default password: root):" mysqlrootpwd
	if [ "$mysqlrootpwd" = "" ]; then
		mysqlrootpwd="root"
	fi
	echo "==========================="
	echo "mysqlrootpwd=$mysqlrootpwd"
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

/etc/init.d/apache2 stop 
dpkg -l |grep mysql 
dpkg -P libmysqlclient15off libmysqlclient15-dev mysql-common 
dpkg -l |grep apache 
dpkg -P apache2 apache2-doc apache2-mpm-prefork apache2-utils apache2.2-common
dpkg -l |grep php 
dpkg -P php 

apt-get update 
apt-get install -y apt-spy
cp /etc/apt/sources.list /etc/apt/sources.list.bak
apt-spy update
apt-spy -d stable -a $area -t 5

apt-get update
apt-get install -y build-essential
apt-get install -y gcc g++ automake autoconf make
apt-get install -y re2c wget cron bzip2 libzip-dev file
apt-get install -y rcconf flex vim nano
apt-get install -y bison m4 awk less
apt-get install -y make  cpp binutils
apt-get install -y unzip tar
apt-get install -y bzip2 unrar p7zip
apt-get install -y libncurses5 libncursefsw5-dev libncurses5-dev
apt-get install -y libtool
apt-get install -y libevent-dev
apt-get install -y libpcre3 libpcre3-dev libpcrecpp0 libperl-dev
apt-get install -y libssl-dev zlibc openssl libsasl2-dev
apt-get install -y libxml2 libxml2-dev
apt-get install -y libltdl3-dev libmcrypt-dev
apt-get install -y libmysqlclient15-dev
apt-get install -y zlib1g zlib1g-dev
apt-get install -y libbz2-1.0 libbz2-dev
apt-get install -y libglib2.0-0 libglib2.0-dev
apt-get install -y libpng3 libfreetype6 libfreetype6-dev
apt-get install -y libjpeg62 libjpeg62-dev libjpeg-dev
apt-get install -y libpng-dev libpng12-0 libpng12-dev
apt-get install -y curl libcurl3 libcurl4-openssl-dev libcurl4-gnutls-dev
apt-get install -y libxslt-dev libpspell-dev
apt-get install -y libmhash2 libmhash-dev
apt-get install -y libpq-dev libpq5 gettext
apt-get install -y libncurses5-dev
apt-get install -y libcurl4-gnutls-dev
apt-get install -y libjpeg-dev
apt-get install -y libpng12-dev
apt-get install -y libxml2-dev
apt-get install -y zlib1g-dev
apt-get install -y libfreetype6-dev
apt-get install -y libssl-dev

echo "============================check files=================================="
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

if [ -s nginx-0.7.65.tar.gz ]; then
  echo "nginx-0.7.65.tar.gz [found]"
  else
  echo "Error: nginx-0.7.65.tar.gz not found!!!download now......"
  wget -c http://soft.vpser.net/web/nginx/nginx-0.7.65.tar.gz
fi

if [ -s mysql-5.1.44.tar.gz ]; then
  echo "mysql-5.1.44.tar.gz [found]"
  else
  echo "Error: mysql-5.1.44.tar.gz not found!!!download now......"
  wget -c http://soft.vpser.net/datebase/mysql/mysql-5.1.44.tar.gz
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

if [ -s p.tar.gz ]; then
  echo "p.tar.gz [found]"
  else
  echo "Error: p.tar.gz not found!!!download now......"
  wget -c http://soft.vpser.net/prober/p.tar.gz
fi

if [ -s suhosin-patch-5.2.10-0.9.7.patch.gz ]; then
  echo "suhosin-patch-5.2.10-0.9.7.patch.gz [found]"
  else
  echo "Error: suhosin-patch-5.2.10-0.9.7.patch.gz not found!!!download now......"
  wget -c http://soft.vpser.net/web/suhosin/suhosin-patch-5.2.10-0.9.7.patch.gz
fi
echo "============================check files=================================="

tar zxvf libiconv-1.13.tar.gz
cd libiconv-1.13/
./configure --prefix=/usr/local/libiconv
make && make install
cd ../

echo "============================mysql install================================="
cd $cur_dir
rm /etc/mysql/my.cnf
rm -rf /etc/mysql/
apt-get remove -y mysql-server
apt-get remove -y mysql-common mysql-client

cd $cur_dir
tar zxvf mysql-5.1.44.tar.gz
cd mysql-5.1.44/
./configure --prefix=/usr/local/mysql --with-extra-charsets=all --enable-thread-safe-client --enable-assembler --with-charset=utf8 --enable-thread-safe-client --with-extra-charsets=all --with-big-tables --with-readline --with-ssl --with-embedded-server --enable-local-infile
make && make install
cd ../

groupadd mysql
useradd -g mysql mysql
cp /usr/local/mysql/share/mysql/my-medium.cnf /etc/my.cnf
/usr/local/mysql/bin/mysql_install_db --user=mysql --basedir=/usr/local/mysql
ln -s /usr/local/mysql/share/mysql /usr/share/

chown -R mysql /usr/local/mysql/var
chgrp -R mysql /usr/local/mysql/.
cp /usr/local/mysql/share/mysql/mysql.server /etc/init.d/mysql
chmod 755 /etc/init.d/mysql

cd /usr/local/mysql/bin
for i in *; do ln -s /usr/local/mysql/bin/$i /usr/bin/$i; done

/etc/init.d/mysql start
/usr/local/mysql/bin/mysqladmin -u root password $mysqlrootpwd

/etc/init.d/mysql restart
/etc/init.d/mysql stop
echo "=========================== mysql intall finished ========================"

echo "========================= php + php extensions install ==================="
cd $cur_dir
tar zxvf php-5.2.10.tar.gz
gzip -d ./suhosin-patch-5.2.10-0.9.7.patch.gz 
gzip -cd php-5.2.10-fpm-0.5.13.diff.gz | patch -d php-5.2.10 -p1
cd php-5.2.10/
patch -p 1 -i ../suhosin-patch-5.2.10-0.9.7.patch
./buildconf --force
./configure --prefix=/usr/local/php --with-config-file-path=/usr/local/php/etc --with-mysql=/usr/local/mysql --with-mysqli=/usr/local/mysql/bin/mysql_config --with-iconv-dir --with-freetype-dir --with-jpeg-dir --with-png-dir --with-zlib --with-libxml-dir=/usr --enable-xml --enable-discard-path --enable-magic-quotes --enable-safe-mode --enable-bcmath --enable-shmop --enable-sysvsem --enable-inline-optimization --with-curl --with-curlwrappers --enable-mbregex --enable-fastcgi --enable-fpm --enable-force-cgi-redirect --enable-mbstring --with-mcrypt --enable-ftp --with-gd --enable-gd-native-ttf --with-openssl --with-mhash --enable-pcntl --enable-sockets --with-xmlrpc --enable-zip --enable-soap --without-pear --with-gettext --with-mime-magic --enable-suhosin
make all install
mkdir -p /usr/local/php/etc/
cp php.ini-dist /usr/local/php/etc/php.ini
strip /usr/local/php/bin/php-cgi
cd ../

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
make && make install
cd ../

# php extensions
sed -i 's#extension_dir = "./"#extension_dir = "/usr/local/php/lib/php/extensions/no-debug-non-zts-20060613/"\nextension = "memcache.so"\nextension = "pdo_mysql.so"\n#' /usr/local/php/etc/php.ini
sed -i 's#output_buffering = Off#output_buffering = On#' /usr/local/php/etc/php.ini
sed -i 's/post_max_size = 8M/post_max_size = 50M/g' /usr/local/php/etc/php.ini
sed -i 's/upload_max_filesize = 2M/upload_max_filesize = 50M/g' /usr/local/php/etc/php.ini
sed -i 's/;date.timezone =/date.timezone = PRC/g' /usr/local/php/etc/php.ini
sed -i 's/; cgi.fix_pathinfo=0/cgi.fix_pathinfo=0/g' /usr/local/php/etc/php.ini


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
echo "======================== php + php extensions install =================="

echo "========================== nginx install ==============================="
groupadd www
useradd -g www www
mkdir -p /home/wwwroot
chmod +w /home/wwwroot
mkdir -p /home/wwwroot/logs
chmod 777 /home/wwwroot/logs
touch /home/wwwroot/logs/nginx_error.log

cd $cur_dir
chown -R www:www /home/wwwroot
rm -f /usr/local/php/etc/php-fpm.conf
cp conf/php-fpm.conf /usr/local/php/etc/php-fpm.conf

echo "ulimit -SHn 51200" >/root/run.sh
echo "/usr/local/php/sbin/php-fpm start" >>/root/run.sh

# nginx
cd $cur_dir
tar zxvf nginx-0.7.65.tar.gz
cd nginx-0.7.65/
./configure --user=www --group=www --prefix=/usr/local/nginx --with-http_stub_status_module --with-http_ssl_module --with-http_gzip_static_module
make && make install
cd ../

cd $cur_dir
rm -f /usr/local/nginx/conf/nginx.conf
cp conf/nginx.conf /usr/local/nginx/conf/nginx.conf
cp conf/dabr.conf /usr/local/nginx/conf/dabr.conf
cp conf/discuz.conf /usr/local/nginx/conf/discuz.conf
cp conf/sablog.conf /usr/local/nginx/conf/sablog.conf
cp conf/typecho.conf /usr/local/nginx/conf/typecho.conf
cp conf/wordpress.conf /usr/local/nginx/conf/wordpress.conf
cp conf/none.conf /usr/local/nginx/conf/none.conf
sed -i 's/www.lnmp.org/'$domain'/g' /usr/local/nginx/conf/nginx.conf

rm -f /usr/local/nginx/conf/fcgi.conf
cp conf/fcgi.conf /usr/local/nginx/conf/fcgi.conf
echo "==================== nginx install finished ==========================="

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

echo "======================= phpMyAdmin install ============================"
cd $cur_dir
tar zxvf phpmyadmin.tar.gz
mv phpmyadmin /home/wwwroot/
echo "==================== phpMyAdmin install finished ======================"

#prober
tar zxvf p.tar.gz
cp p.php /home/wwwroot/p.php

#start up
cp /root/run.sh /etc/init.d/nginx.sh
update-rc.d nginx.sh defaults
update-rc.d mysql defaults

#set timezone
cp -f /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

cd $cur_dir
cp lnmp /root/lnmp
chmod +x /root/lnmp

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

echo "Install lnmp 0.4 finished! enjoy it."
echo "========================================================================="
echo "LNMP V0.4 for Debian/Ubuntu VPS , Written by Licess "
echo "========================================================================="
echo ""
echo "For more information please visit http://www.lnmp.org/"
echo ""
echo "lnmp status manage: /root/lnmp {start|stop|reload|restart|kill|status}"
echo "default mysql root password:$mysqlrootpwd"
echo "phpinfo : http://$domain/phpinfo.php"
echo "phpMyAdmin : http://$domain/phpmyadmin/"
echo "Prober : http://$domain/p.php"
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