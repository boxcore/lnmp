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
echo "LNMP V0.9 for Ubuntu VPS ,  Written by Licess "
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

#do you want to install the InnoDB Storage Engine?

echo "==========================="

	installinnodb="n"
	echo "Do you want to install the InnoDB Storage Engine?"
	read -p "(Default no,if you want please input: y ,if not please press the enter button):" installinnodb

	case "$installinnodb" in
	y|Y|Yes|YES|yes|yES|yEs|YeS|yeS)
	echo "You will install the InnoDB Storage Engine"
	installinnodb="y"
	;;
	n|N|No|NO|no|nO)
	echo "You will NOT install the InnoDB Storage Engine!"
	installinnodb="n"
	;;
	*)
	echo "INPUT error,The InnoDB Storage Engine will NOT install!"
	installinnodb="n"
	esac

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

dpkg -l |grep mysql 
dpkg -P libmysqlclient15off libmysqlclient15-dev mysql-common 
dpkg -l |grep apache 
dpkg -P apache2 apache2-doc apache2-mpm-prefork apache2-utils apache2.2-common
dpkg -l |grep php 
dpkg -P php 

#Synchronization time
rm -rf /etc/localtime
ln -s /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

apt-get install -y ntpdate
ntpdate -u pool.ntp.org
date

#Disable SeLinux
if [ -s /etc/selinux/config ]; then
sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config
fi

if [ -s /etc/ld.so.conf.d/libc6-xen.conf ]; then
sed -i 's/hwcap 1 nosegneg/hwcap 0 nosegneg/g' /etc/ld.so.conf.d/libc6-xen.conf
fi

apt-get update
apt-get remove -y apache2 apache2-doc apache2-utils apache2.2-common apache2.2-bin apache2-mpm-prefork apache2-doc apache2-mpm-worker mysql-client mysql-server mysql-common php
killall apache2

apt-get update
apt-get autoremove -y
apt-get -fy install
apt-get install -y build-essential gcc g++ make
for packages in build-essential gcc g++ make automake autoconf re2c wget cron bzip2 libzip-dev libc6-dev file rcconf flex vim nano bison m4 gawk less make cpp binutils diffutils unzip tar bzip2 libbz2-dev unrar p7zip libncurses5-dev libncurses5 libncurses5-dev libncurses5-dev libtool libevent-dev libpcre3 libpcre3-dev libpcrecpp0  libssl-dev zlibc openssl libsasl2-dev libxml2 libxml2-dev libltdl3-dev libltdl-dev libmcrypt-dev libmysqlclient15-dev zlib1g zlib1g-dev libbz2-1.0 libbz2-dev libglib2.0-0 libglib2.0-dev libpng3 libfreetype6 libfreetype6-dev libjpeg62 libjpeg62-dev libjpeg-dev libpng-dev libpng12-0 libpng12-dev curl libcurl3 libmhash2 libmhash-dev libpq-dev libpq5 gettext libncurses5-dev libcurl4-gnutls-dev libjpeg-dev libpng12-dev libxml2-dev zlib1g-dev libfreetype6 libfreetype6-dev libssl-dev libcurl3 libcurl4-openssl-dev libcurl4-gnutls-dev mcrypt libcap-dev;
do apt-get install -y $packages --force-yes;apt-get -fy install;apt-get -y autoremove; done

echo "============================check files=================================="
if [ -s php-5.2.17.tar.gz ]; then
  echo "php-5.2.17.tar.gz [found]"
  else
  echo "Error: php-5.2.17.tar.gz not found!!!download now......"
  wget -c http://soft.vpser.net/web/php/php-5.2.17.tar.gz
fi

if [ -s php-5.2.17-fpm-0.5.14.diff.gz ]; then
  echo "php-5.2.17-fpm-0.5.14.diff.gz [found]"
  else
  echo "Error: php-5.2.17-fpm-0.5.14.diff.gz not found!!!download now......"
  wget -c http://soft.vpser.net/web/phpfpm/php-5.2.17-fpm-0.5.14.diff.gz
fi

if [ -s memcache-3.0.6.tgz ]; then
  echo "memcache-3.0.6.tgz [found]"
  else
  echo "Error: memcache-3.0.6.tgz not found!!!download now......"
  wget -c http://soft.vpser.net/web/memcache/memcache-3.0.6.tgz
fi

if [ -s pcre-8.12.tar.gz ]; then
  echo "pcre-8.12.tar.gz [found]"
  else
  echo "Error: pcre-8.12.tar.gz not found!!!download now......"
wget -c http://soft.vpser.net/web/pcre/pcre-8.12.tar.gz
fi

if [ -s nginx-1.0.15.tar.gz ]; then
  echo "nginx-1.0.15.tar.gz [found]"
  else
  echo "Error: nginx-1.0.15.tar.gz not found!!!download now......"
  wget -c http://soft.vpser.net/web/nginx/nginx-1.0.15.tar.gz
fi

if [ -s mysql-5.1.60.tar.gz ]; then
  echo "mysql-5.1.60.tar.gz [found]"
  else
  echo "Error: mysql-5.1.60.tar.gz not found!!!download now......"
  wget -c http://soft.vpser.net/datebase/mysql/mysql-5.1.60.tar.gz
fi

if [ -s libiconv-1.14.tar.gz ]; then
  echo "libiconv-1.14.tar.gz [found]"
  else
  echo "Error: libiconv-1.14.tar.gz not found!!!download now......"
  wget -c http://soft.vpser.net/web/libiconv/libiconv-1.14.tar.gz
fi

if [ -s libmcrypt-2.5.8.tar.gz ]; then
  echo "libmcrypt-2.5.8.tar.gz [found]"
  else
  echo "Error: libmcrypt-2.5.8.tar.gz not found!!!download now......"
  wget -c  http://soft.vpser.net/web/libmcrypt/libmcrypt-2.5.8.tar.gz
fi

if [ -s phpmyadmin-latest.tar.gz ]; then
  echo "phpmyadmin-latest.tar.gz [found]"
  else
  echo "Error: phpmyadmin-latest.tar.gz not found!!!download now......"
  wget -c http://soft.vpser.net/datebase/phpmyadmin/phpmyadmin-latest.tar.gz
fi

if [ -s p.tar.gz ]; then
  echo "p.tar.gz [found]"
  else
  echo "Error: p.tar.gz not found!!!download now......"
  wget -c http://soft.vpser.net/prober/p.tar.gz
fi

if [ -s autoconf-2.13.tar.gz ]; then
  echo "autoconf-2.13.tar.gz [found]"
  else
  echo "Error: autoconf-2.13.tar.gz not found!!!download now......"
  wget -c http://soft.vpser.net/lib/autoconf/autoconf-2.13.tar.gz
fi
echo "============================check files=================================="

cd $cur_dir

tar zxvf autoconf-2.13.tar.gz
cd autoconf-2.13/
./configure --prefix=/usr/local/autoconf-2.13
make && make install
cd ../

cd $cur_dir
tar zxvf libiconv-1.14.tar.gz
cd libiconv-1.14/
./configure
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

ln -s /usr/local/lib/libmcrypt.la /usr/lib/libmcrypt.la
ln -s /usr/local/lib/libmcrypt.so /usr/lib/libmcrypt.so
ln -s /usr/local/lib/libmcrypt.so.4 /usr/lib/libmcrypt.so.4
ln -s /usr/local/lib/libmcrypt.so.4.4.8 /usr/lib/libmcrypt.so.4.4.8

if [ `getconf WORD_BIT` = '32' ] && [ `getconf LONG_BIT` = '64' ] ; then
        ln -s /usr/lib/x86_64-linux-gnu/libpng* /usr/lib/
        ln -s /usr/lib/x86_64-linux-gnu/libjpeg* /usr/lib/
else
        ln -s /usr/lib/i386-linux-gnu/libpng* /usr/lib/
        ln -s /usr/lib/i386-linux-gnu/libjpeg* /usr/lib/
fi

ulimit -v unlimited

if [ ! `grep -l "/lib"    '/etc/ld.so.conf'` ]; then
	echo "/lib" >> /etc/ld.so.conf
fi

if [ ! `grep -l '/usr/lib'    '/etc/ld.so.conf'` ]; then
	echo "/usr/lib" >> /etc/ld.so.conf
fi

if [ -d "/usr/lib64" ] && [ ! `grep -l '/usr/lib64'    '/etc/ld.so.conf'` ]; then
	echo "/usr/lib64" >> /etc/ld.so.conf
fi

if [ ! `grep -l '/usr/local/lib'    '/etc/ld.so.conf'` ]; then
	echo "/usr/local/lib" >> /etc/ld.so.conf
fi

ldconfig

cat >>/etc/security/limits.conf<<eof
* soft nproc 65535
* hard nproc 65535
* soft nofile 65535
* hard nofile 65535
eof

cat >>/etc/sysctl.conf<<eof
fs.file-max=65535
eof
echo "============================mysql install================================="
cd $cur_dir
rm /etc/my.cnf
rm /etc/mysql/my.cnf
rm -rf /etc/mysql/
apt-get remove -y mysql-server
apt-get remove -y mysql-common mysql-client

cd $cur_dir
tar zxvf mysql-5.1.60.tar.gz
cd mysql-5.1.60/
if [ $installinnodb = "y" ]; then
./configure --prefix=/usr/local/mysql --with-extra-charsets=complex --enable-thread-safe-client --enable-assembler --with-mysqld-ldflags=-all-static --with-charset=utf8 --enable-thread-safe-client --with-big-tables --with-readline --with-ssl --with-embedded-server --enable-local-infile --with-plugins=innobase
else
./configure --prefix=/usr/local/mysql --with-extra-charsets=complex --enable-thread-safe-client --enable-assembler --with-mysqld-ldflags=-all-static --with-charset=utf8 --enable-thread-safe-client --with-big-tables --with-readline --with-ssl --with-embedded-server --enable-local-infile
fi
cat Makefile | sed '/set -ex;/,/done/d' > Makefile.1
rm Makefile
mv Makefile.1 Makefile
make && make install
cd ../

groupadd mysql
useradd -s /sbin/nologin -g mysql mysql
cp /usr/local/mysql/share/mysql/my-medium.cnf /etc/my.cnf
sed -i 's/skip-locking/skip-external-locking/g' /etc/my.cnf
if [ $installinnodb = "y" ]; then
sed -i 's:#innodb:innodb:g' /etc/my.cnf
fi

/usr/local/mysql/bin/mysql_install_db --user=mysql --basedir=/usr/local/mysql
ln -s /usr/local/mysql/share/mysql /usr/share/

chown -R mysql /usr/local/mysql/var
chgrp -R mysql /usr/local/mysql/.
cp /usr/local/mysql/share/mysql/mysql.server /etc/init.d/mysql
chmod 755 /etc/init.d/mysql

cat > /etc/ld.so.conf.d/mysql.conf<<EOF
/usr/local/mysql/lib/mysql
/usr/local/lib
EOF
ldconfig

ln -s /usr/local/mysql/lib/mysql /usr/lib/mysql
ln -s /usr/local/mysql/include/mysql /usr/include/mysql

ln -s /usr/local/mysql/bin/myisamchk /usr/bin/
ln -s /usr/local/mysql/bin/mysql /usr/bin/
ln -s /usr/local/mysql/bin/mysqldump /usr/bin/

/etc/init.d/mysql start
/usr/local/mysql/bin/mysqladmin -u root password $mysqlrootpwd

cat > /tmp/mysql_sec_script<<EOF
use mysql;
update user set password=password('$mysqlrootpwd') where user='root';
delete from user where not (user='root') ;
delete from user where user='root' and password=''; 
drop database test;
DROP USER ''@'%';
flush privileges;
EOF

/usr/local/mysql/bin/mysql -u root -p$mysqlrootpwd -h localhost < /tmp/mysql_sec_script

rm -f /tmp/mysql_sec_script

/etc/init.d/mysql restart
/etc/init.d/mysql stop
echo "=========================== mysql intall completed ========================"

echo "========================= php + php extensions install ==================="
cd $cur_dir
export PHP_AUTOCONF=/usr/local/autoconf-2.13/bin/autoconf
export PHP_AUTOHEADER=/usr/local/autoconf-2.13/bin/autoheader
tar zxvf php-5.2.17.tar.gz
gzip -cd php-5.2.17-fpm-0.5.14.diff.gz | patch -d php-5.2.17 -p1
cd php-5.2.17/
wget -c http://soft.vpser.net/web/php/bug/php-5.2.17-max-input-vars.patch
patch -p1 < php-5.2.17-max-input-vars.patch
./buildconf --force
./configure --prefix=/usr/local/php --with-config-file-path=/usr/local/php/etc --with-mysql=/usr/local/mysql --with-mysqli=/usr/local/mysql/bin/mysql_config --with-iconv-dir --with-freetype-dir --with-jpeg-dir --with-png-dir --with-zlib --with-libxml-dir=/usr --enable-xml --enable-discard-path --enable-magic-quotes --enable-safe-mode --enable-bcmath --enable-shmop --enable-sysvsem --enable-inline-optimization --with-curl --with-curlwrappers --enable-mbregex --enable-fastcgi --enable-fpm --enable-force-cgi-redirect --enable-mbstring --with-mcrypt --enable-ftp --with-gd --enable-gd-native-ttf --with-openssl --with-mhash --enable-pcntl --enable-sockets --with-xmlrpc --enable-zip --enable-soap --without-pear --with-gettext --with-mime-magic
cd ext/openssl/
wget -c http://soft.vpser.net/lnmp/ext/debian_patches_disable_SSLv2_for_openssl_1_0_0.patch
patch -p3 <debian_patches_disable_SSLv2_for_openssl_1_0_0.patch
cd ../../
make ZEND_EXTRA_LIBS='-liconv'
make install

mkdir -p /usr/local/php/etc
cp php.ini-dist /usr/local/php/etc/php.ini
strip /usr/local/php/bin/php-cgi
cd ../

ln -s /usr/local/php/bin/php /usr/bin/php
ln -s /usr/local/php/bin/phpize /usr/bin/phpize
ln -s /usr/local/php/sbin/php-fpm /usr/bin/php-fpm

cd $cur_dir
tar zxvf memcache-3.0.6.tgz
cd memcache-3.0.6/
/usr/local/php/bin/phpize
./configure --with-php-config=/usr/local/php/bin/php-config
make && make install
cd ../

cd $cur_dir/php-5.2.17/ext/pdo_mysql/
/usr/local/php/bin/phpize
./configure --with-php-config=/usr/local/php/bin/php-config --with-pdo-mysql=/usr/local/mysql
make && make install
cd $cur_dir/

# php extensions
sed -i 's#extension_dir = "./"#extension_dir = "/usr/local/php/lib/php/extensions/no-debug-non-zts-20060613/"\nextension = "memcache.so"\nextension = "pdo_mysql.so"\n#' /usr/local/php/etc/php.ini
sed -i 's#output_buffering = Off#output_buffering = On#' /usr/local/php/etc/php.ini
sed -i 's/post_max_size = 8M/post_max_size = 50M/g' /usr/local/php/etc/php.ini
sed -i 's/upload_max_filesize = 2M/upload_max_filesize = 50M/g' /usr/local/php/etc/php.ini
sed -i 's/;date.timezone =/date.timezone = PRC/g' /usr/local/php/etc/php.ini
sed -i 's/short_open_tag = Off/short_open_tag = On/g' /usr/local/php/etc/php.ini
sed -i 's/; cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g' /usr/local/php/etc/php.ini
sed -i 's/; cgi.fix_pathinfo=0/cgi.fix_pathinfo=0/g' /usr/local/php/etc/php.ini
sed -i 's/max_execution_time = 30/max_execution_time = 300/g' /usr/local/php/etc/php.ini
sed -i 's/disable_functions =.*/disable_functions = passthru,exec,system,chroot,scandir,chgrp,chown,shell_exec,proc_open,proc_get_status,ini_alter,ini_alter,ini_restore,dl,pfsockopen,openlog,syslog,readlink,symlink,popepassthru,stream_socket_server,fsocket,fsockopen/g' /usr/local/php/etc/php.ini

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

wget -c http://soft.vpser.net/lnmp/ext/init.d.php-fpm5.2
cp init.d.php-fpm5.2 /etc/init.d/php-fpm
chmod +x /etc/init.d/php-fpm
echo "======================== php + php extensions install =================="

echo "========================== nginx install ==============================="
groupadd www
useradd -s /sbin/nologin -g www www

mkdir -p /home/wwwroot
chmod +w /home/wwwroot
mkdir -p /home/wwwlogs
chmod 777 /home/wwwlogs
touch /home/wwwlogs/nginx_error.log

cd $cur_dir
chown -R www:www /home/wwwroot
rm -f /usr/local/php/etc/php-fpm.conf
cp conf/php-fpm.conf /usr/local/php/etc/php-fpm.conf

# nginx
cd $cur_dir
tar zxvf pcre-8.12.tar.gz
cd pcre-8.12/
./configure
make && make install
cd ../

ldconfig

tar zxvf nginx-1.0.15.tar.gz
cd nginx-1.0.15/
./configure --user=www --group=www --prefix=/usr/local/nginx --with-http_stub_status_module --with-http_ssl_module --with-http_gzip_static_module --with-ipv6
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
cp conf/discuzx.conf /usr/local/nginx/conf/discuzx.conf
cp conf/wp2.conf /usr/local/nginx/conf/wp2.conf
cp conf/none.conf /usr/local/nginx/conf/none.conf
cp conf/phpwind.conf /usr/local/nginx/conf/phpwind.conf
sed -i 's/www.lnmp.org/'$domain'/g' /usr/local/nginx/conf/nginx.conf

rm -f /usr/local/nginx/conf/fcgi.conf
cp conf/fcgi.conf /usr/local/nginx/conf/fcgi.conf
echo "==================== nginx install completed ==========================="
#phpinfo
cat >/home/wwwroot/phpinfo.php<<eof
<?
phpinfo();
?>
eof

echo "======================= phpMyAdmin install ============================"
cd $cur_dir
#phpmyadmin
tar zxvf phpmyadmin-latest.tar.gz
mv phpMyAdmin-3.4.8-all-languages /home/wwwroot/phpmyadmin/
cp conf/config.inc.php /home/wwwroot/phpmyadmin/config.inc.php
sed -i 's/LNMPORG/LNMP.org'$RANDOM'VPSer.net/g' /home/wwwroot/phpmyadmin/config.inc.php
mkdir /home/wwwroot/phpmyadmin/upload/
mkdir /home/wwwroot/phpmyadmin/save/
chmod 755 -R /home/wwwroot/phpmyadmin/
chown www:www -R /home/wwwroot/phpmyadmin/
echo "==================== phpMyAdmin install completed ======================"

#prober
tar zxvf p.tar.gz
cp p.php /home/wwwroot/p.php

cp conf/index.html /home/wwwroot/index.html

echo "============================add nginx and php-fpm on startup============================"
#start up
echo "Download new nginx init.d file......"
wget -c http://soft.vpser.net/lnmp/ext/init.d.nginx
cp init.d.nginx /etc/init.d/nginx
chmod +x /etc/init.d/nginx
update-rc.d -f mysql defaults
update-rc.d -f nginx defaults
update-rc.d -f php-fpm defaults

cd $cur_dir
cp lnmp /root/lnmp
chmod +x /root/lnmp
cp vhost.sh /root/vhost.sh
chmod +x /root/vhost.sh
echo "===========================add nginx and php-fpm on startup completed===================="
echo "Starting LNMP..."
/etc/init.d/mysql start
/etc/init.d/php-fpm start
/etc/init.d/nginx start

#add 80 port to iptables
if [ -s /sbin/iptables ]; then
/sbin/iptables -I INPUT -p tcp --dport 80 -j ACCEPT
/sbin/iptables-save
fi
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
if [ -s /usr/local/nginx ] && [ -s /usr/local/php ] && [ -s /usr/local/mysql ]; then

echo "Install LNMP V0.9 completed! enjoy it."
echo "========================================================================="
echo "LNMP V0.9 for Ubuntu VPS , Written by Licess "
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
/root/lnmp status
netstat -ntl
else
  echo "Sorry,Failed to install LNMP!"
  echo "Please visit http://bbs.vpser.net/forum-25-1.html feedback errors and logs."
  echo "You can download lnmp.log from your server,and upload lnmp.log to LNMP Forum."
fi
fi
