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
printf "Install Apache for LNMP V0.7  ,  Written by Licess \n"
printf "=======================================================================\n"
printf "LNMP is a tool to auto-compile & install Nginx+MySQL+PHP on Linux \n"
printf "This script is a tool to install Apache for lnmp \n"
printf "\n"
printf "For more information please visit http://www.lnmp.org \n"
printf "=======================================================================\n"
cur_dir=$(pwd)
ipv4=`ifconfig -a|grep inet|grep -v 127.0.0.1|grep -v inet6|awk '{print $2}'|tr -d "addr:"`

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

#set Server Administrator Email Address

	ServerAdmin=""
	read -p "Please input Administrator Email Address:" ServerAdmin
	if [ "$ServerAdmin" == "" ]; then
		echo "Administrator Email Address will set to webmaster@example.com!"
		ServerAdmin="webmaster@example.com"
	else
	echo "==========================="
	echo Server Administrator Email="$ServerAdmin"
	echo "==========================="
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
	echo "Press any key to start install Apache for LNMP or Press Ctrl+C to cancel..."
	char=`get_char`

printf "===================== Check And Download Files =================\n"

if [ -s httpd-2.2.17.tar.gz ]; then
  echo "httpd-2.2.17.tar.gz [found]"
  else
  echo "Error: httpd-2.2.17.tar.gz not found!!!download now......"
  wget -c http://soft.vpser.net/web/apache/httpd-2.2.17.tar.gz
fi

if [ -s mod_rpaf-0.6.tar.gz ]; then
  echo "mod_rpaf-0.6.tar.gz [found]"
  else
  echo "Error: mod_rpaf-0.6.tar.gz not found!!!download now......"
  wget -c http://soft.vpser.net/web/apache/rpaf/mod_rpaf-0.6.tar.gz
fi

if [ -s php-5.2.17.tar.gz ]; then
  echo "php-5.2.17.tar.gz [found]"
  else
  echo "Error: php-5.2.17.tar.gz not found!!!download now......"
  wget -c http://us2.php.net/distributions/php-5.2.17.tar.gz
fi

if [ -s PDO_MYSQL-1.0.2.tgz ]; then
  echo "PDO_MYSQL-1.0.2.tgz [found]"
  else
  echo "Error: PDO_MYSQL-1.0.2.tgz not found!!!download now......"
  wget -c http://pecl.php.net/get/PDO_MYSQL-1.0.2.tgz
fi

if [ -s memcache-3.0.5.tgz ]; then
  echo "memcache-3.0.5.tgz [found]"
  else
  echo "Error: memcache-3.0.5.tgz not found!!!download now......"
  wget -c http://pecl.php.net/get/memcache-3.0.5.tgz
fi
printf "=========================== install Apache ======================\n"

echo "Backup old php configure files....."
mkdir /root/lnmpbackup/
cp /root/lnmp /root/lnmpbackup/
cp /usr/local/php/etc/php.ini /root/lnmpbackup/
cp /usr/local/php/etc/php-fpm.conf /root/lnmpbackup/

cd $cur_dir
tar zxvf httpd-2.2.17.tar.gz
cd httpd-2.2.17/
./configure --prefix=/usr/local/apache --enable-headers --enable-mime-magic --enable-proxy --enable-so --enable-rewrite --enable-ssl --enable-suexec --disable-userdir --with-included-apr --with-mpm=prefork --with-ssl=/usr --disable-userdir --disable-cgid --disable-cgi
make && make install
cd ..

mv /usr/local/apache/conf/httpd.conf /usr/local/apache/conf/httpd.conf.bak
cp $cur_dir/conf/httpd.conf /usr/local/apache/conf/httpd.conf
cp $cur_dir/conf/httpd-default.conf /usr/local/apache/conf/extra/httpd-default.conf
cp $cur_dir/conf/httpd-vhosts.conf /usr/local/apache/conf/extra/httpd-vhosts.conf
cp $cur_dir/conf/httpd-mpm.conf /usr/local/apache/conf/extra/httpd-mpm.conf
cp $cur_dir/conf/rpaf.conf /usr/local/apache/conf/extra/rpaf.conf

sed -i 's/#ServerName www.example.com:80/ServerName '$domain':88/g' /usr/local/apache/conf/httpd.conf
sed -i 's/ServerAdmin you@example.com/ServerAdmin '$ServerAdmin'/g' /usr/local/apache/conf/httpd.conf
sed -i 's/www.lnmp.org/'$domain'/g' /usr/local/apache/conf/extra/httpd-vhosts.conf
sed -i 's/webmaster@example.com/'$ServerAdmin'/g' /usr/local/apache/conf/extra/httpd-vhosts.conf
mkdir -p /usr/local/apache/conf/vhost
cat >>/usr/local/apache/conf/httpd.conf<<EOF
Include conf/vhost/*.conf
EOF

tar -zxvf mod_rpaf-0.6.tar.gz
cd mod_rpaf-0.6/
/usr/local/apache/bin/apxs -i -c -n mod_rpaf-2.0.so mod_rpaf-2.0.c
cd ..

ln -s /usr/local/lib/libltdl.so.3 /usr/lib/libltdl.so.3

#sed -i 's#your_ips#'$ipv4'#g' /usr/local/apache/conf/extra/rpaf.conf
echo "Stop php-fpm....."
if [ -s /usr/local/php/sbin/php-fpm ]; then
/usr/local/php/sbin/php-fpm stop
else
/etc/init.d/php-fpm stop
fi

rm -rf /usr/local/php/
cd $cur_dir
if [ -s php-5.2.17 ]; then
rm -rf php-5.2.17
fi
tar zxvf php-5.2.17.tar.gz
cd php-5.2.17/
./configure --prefix=/usr/local/php --with-config-file-path=/usr/local/php/etc --with-apxs2=/usr/local/apache/bin/apxs --with-mysql=/usr/local/mysql --with-mysqli=/usr/local/mysql/bin/mysql_config --with-iconv-dir --with-freetype-dir --with-jpeg-dir --with-png-dir --with-zlib --with-libxml-dir=/usr --enable-xml --disable-rpath --enable-discard-path --enable-magic-quotes --enable-safe-mode --enable-bcmath --enable-shmop --enable-sysvsem --enable-inline-optimization --with-curl --with-curlwrappers --enable-mbregex --enable-mbstring --with-mcrypt --enable-ftp --with-gd --enable-gd-native-ttf --with-openssl --with-mhash --enable-pcntl --enable-sockets --with-xmlrpc --enable-zip --enable-soap --without-pear --with-gettext --with-mime-magic

rm -rf libtool
cp /usr/local/apache/build/libtool .

make ZEND_EXTRA_LIBS='-liconv'
make install

mkdir -p /usr/local/php/etc
cp php.ini-dist /usr/local/php/etc/php.ini
cd ../

cd $cur_dir
tar zxvf memcache-3.0.5.tgz
cd memcache-3.0.5/
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
sed -i 's/short_open_tag = Off/short_open_tag = On/g' /usr/local/php/etc/php.ini
sed -i 's/; cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g' /usr/local/php/etc/php.ini
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

cd $cur_dir
cp conf/proxy.conf /usr/local/nginx/conf/proxy.conf
mv /usr/local/nginx/conf/nginx.conf /root/lnmpbackup/
cp conf/nginx_a.conf /usr/local/nginx/conf/nginx.conf
sed -i 's/www.lnmp.org/'$domain'/g' /usr/local/nginx/conf/nginx.conf

echo "Download new Apache init.d file......"
wget -c http://soft.vpser.net/lnmp/ext/init.d.httpd
cp init.d.httpd /etc/init.d/httpd
chmod +x /etc/init.d/httpd

echo "Stop Nginx......"
kill `cat /usr/local/nginx/logs/nginx.pid`
echo "Test Nginx Confgure....."
/usr/local/nginx/sbin/nginx -t
echo "Starting Nginx......"
if [ -s /usr/local/nginx/logs/nginx.pid ]; then
kill `cat /usr/local/nginx/logs/nginx.pid`
fi
/usr/local/nginx/sbin/nginx
echo "Starting Apache....."
/etc/init.d/httpd restart

echo "Remove old startup files and Add new startup file....."
if [ -s /etc/debian_version ]; then
update-rc.d -f httpd defaults
update-rc.d -f php-fpm remove
fi

if [ -s /etc/redhat-release ]; then
sed -i '/php-fpm/'d /etc/rc.local
chkconfig --level 345 php-fpm off
chkconfig --level 345 httpd on
fi

cd $cur_dir
rm -f /etc/init.d/php-fpm
mv /root/vhost.sh /root/lnmp.vhost.sh
cp vhost_lnmpa.sh /root/vhost.sh
chmod +x /root/vhost.sh
cp lnmpa /root/
chmod +x /root/lnmpa

printf "====================== Upgrade to LNMPA completed =====================\n"
printf "You have successfully upgrade from lnmp to lnmpa,enjoy it!\n"
printf "=======================================================================\n"
printf "LNMP is a tool to auto-compile & install Nginx+MySQL+PHP on Linux \n"
printf "This script is a tool to upgrade from lnmp to lnmpa \n"
printf "\n"
printf "For more information please visit http://www.lnmp.org \n"
printf "=======================================================================\n"