#!/bin/bash

tar -zxf zlib-1.2.5.tar.gz
cd zlib-1.2.5/
./configure --prefix=/usr/local
## CFLAGS=-O3 -D_LARGEFILE64_SOURCE=1 修改为
## CFLAGS=-O3 -D_LARGEFILE64_SOURCE=1 -fPIC
# 解决 编译libxml2报错./.libs/libxml2.so: undefined reference to `gzopen64'
make && make install


tar -zxf libpng-1.6.2.tar.gz
cd libpng-1.6.2/
./configure --prefix=/usr/local
make && make install

tar -zxf jpegsrc.v9a.tar.gz
cd jpeg-9a/
./configure --prefix=/usr/local
make && make install

tar -zxf libiconv-1.14.tar.gz 
cd libiconv-1.14/
./configure --prefix=/usr/local
make
make install

tar -zxf freetype-2.5.3.tar.gz
cd freetype-2.5.3/
./configure --prefix=/usr/local
make
make install
mkdir -pv /usr/include/freetype2/freetype
ln -s /usr/local/include/freetype2/freetype.h /usr/include/freetype2/freetype/freetype.h

# tar -zxf gd-2.0.35.tar.gz
# cd gd-2.0.35/
# ./configure --prefix=/usr/local --with-libiconv-prefix=/usr/local --with-png=/usr/local --with-freetype=/usr/local --with-jpeg=/usr/local
# make
# make install

tar -zxf gd-2.0.36RC1.tar.gz
cd gd-2.0.36RC1/
./configure --prefix=/usr/local --with-libiconv-prefix=/usr/local --with-png=/usr/local --with-freetype=/usr/local --with-jpeg=/usr/local
make 
make install


tar -zxf libxml2-2.9.1.tar.gz
cd libxml2-2.9.1/
./configure --prefix=/usr/local
# vim Makefile
# CFLAGS = -g -O2 -pedantic -W -Wformat -Wunused -Wimplicit -Wreturn-type -Wswitch -Wcomment -Wtrigraphs -Wformat -Wchar-subscripts -Wuninitialized -Wparentheses -Wshadow -Wpointer-arith -Wcast-align -Wwrite-strings -Waggregate-return -Wstrict-prototypes -Wmissing-prototypes -Wnested-externs -Winline -Wredundant-decls -Wno-long-long 后面添加 -fPIC
# 
# 
# 安装的是libxml2-2.9.1版本，直接./configure 然后make出现./.libs/libxml2.so: undefined reference to `gzopen64。
./configure --prefix=/usr/local --with-zlib=/usr/local/lib/libz.a --with-python=/usr/lib/python2.6
make
make install



##############
tar -zxf mhash-0.9.9.9.tar.gz
cd mhash-0.9.9.9/
./configure --prefix=/usr/local
make
make install

tar -zxf libmcrypt-2.5.8.tar.gz
cd libmcrypt-2.5.8/
./configure --prefix=/usr/local
make
make install

tar -zxf mcrypt-2.6.8.tar.gz
cd mcrypt-2.6.8/
ln -s   /usr/local/bin/libmcrypt-config   /usr/local/bin
LD_LIBRARY_PATH=/usr/local/lib ./configure --prefix=/usr/local
make
make install
##########


tar -zxf libssh2-1.2.7.tar.gz
cd libssh2-1.2.7/
./configure --prefix=/usr/local
make
make install

wget http://curl.haxx.se/download/curl-7.21.2.tar.gz
tar -zxf curl-7.21.2.tar.gz
cd curl-7.21.2/
./configure --prefix=/usr/local --with-ssl=/usr/local/ssl --with-libssh2=/usr/local
make
make install


#########
# apache版
# tar -zxf php-5.3.9.tar.gz
# cd php-5.3.9/
# ./configure --prefix=/usr/local/php \
# --with-apxs2=/usr/local/apache/bin/apxs \
# --with-mysql=/usr/local/mysql \
# --with-mysqli=/usr/local/mysql/bin/mysql_config \
# --with-jpeg-dir=/usr/local \
# --with-png-dir=/usr/local \
# --with-zlib-dir=/usr/local \
# --with-freetype-dir=/usr/local \
# --with-iconv-dir=/usr/local \
# --enable-gd-native-ttf \
# --enable-gd-jis-conv \
# --with-gd=/usr/local \
# --with-libxml-dir=/usr/local \
# --with-mhash=/usr/local \
# --with-mcrypt=/usr/local \
# --with-openssl=/usr/local \
# --with-curl=/usr/local \
# --with-curlwrappers \
# --enable-bcmath \
# --enable-wddx \
# --enable-calendar \
# --enable-mbstring \
# --enable-ftp \
# --enable-zip \
# --enable-sockets
# make && make install

# nginx版
# 报错 ：make: *** [ext/gd/gd.lo] Error 1
# ----------------------
# tar -zxf php-5.3.9.tar.gz
# cd php-5.3.9/
# ./configure --prefix=/usr/local/php \
# --with-config-file-path=/usr/local/php/etc \
# --enable-fpm \
# --with-fpm-user=www \
# --with-fpm-group=www \
# --with-mysql=/usr/local/mysql \
# --with-mysql-sock \
# --with-pdo-mysql=/usr/local/mysql/bin/mysql \
# --with-zlib-dir=/usr/local \
# --with-libxml-dir=/usr/local \
# --with-jpeg-dir=/usr/local \
# --with-png-dir=/usr/local \
# --with-freetype-dir=/usr/local \
# --with-iconv-dir=/usr/local \
# --enable-gd-native-ttf \
# --enable-gd-jis-conv \
# --with-gd=/usr/local \
# --with-mhash=/usr/local \
# --with-mcrypt=/usr/local \
# --with-openssl \
# --with-curl=/usr/local \
# --with-curlwrappers \
# --with-libxml-dir \
# --with-xmlrpc \
# --with-pear \
# --enable-mbstring \
# --enable-sysvshm \
# --enable-zip  \
# --enable-soap \
# --enable-sockets
# make
# make install

## old nginx version  测试OK
./configure --prefix=/usr/local/php \
--with-config-file-path=/usr/local/php/etc \
--enable-fpm \
--with-fpm-user=www \
--with-fpm-group=www \
--with-mysql=/usr/local/mysql \
--with-mysql-sock \
--with-pdo-mysql=/usr/local/mysql/bin/mysql \
--with-zlib  \
--with-libxml-dir \
--with-curl \
--with-xmlrpc \
--with-openssl \
--with-mhash  \
--with-pear \
--enable-mbstring \
--enable-sysvshm \
--enable-zip  \
--enable-soap \
--enable-sockets

cp -rf php.ini-development /usr/local/php/etc/php.ini
sed -i "s#\;date\.timezone \=#date\.timezone \= \"Asia\/Chongqing\"#g" /usr/local/php/etc/php.ini

# install  php-fpm service
cp -rf sapi/fpm/init.d.php-fpm  /etc/rc.d/init.d/php-fpm
chmod +x /etc/init.d/php-fpm
chkconfig --add php-fpm
chkconfig php-fpm on



# setting php-fpm conf
cp -rf /usr/local/php/etc/php-fpm.conf.default /usr/local/php/etc/php-fpm.conf
if [ -s /usr/lib/php/modules/gd.so ]; then
    sed -i '/;extension=php_zip.dll/a\extension=/usr/lib/php/modules/gd.so' /usr/local/php/etc/php.ini
fi
# vi php-fpm.conf 
# //一般配置的依据如下
# ===============================================
# 内存小于4G服务器（值可逐级递减）：
# 修改如下参数：
# pm=dynamic
# pm.max_children=40
# pm.start_servers=10
# pm.min_spare_servers=10
# pm.max_spare_servers=40
#  ******************************
# 内存大于4G服务器（值可逐级递增）：
# 修改如下参数：
# pm=static
# pm.max_children=100
# ===============================================
MemTotal=`free -m | grep Mem | awk '{print  $2}'`
export LNMP_MEM=$MemTotal
if [ "$LNMP_MEM" -gt "3900" ]; then
    sed -i 's:pm = dynamic:pm = static:g' /usr/local/php/etc/php-fpm.conf
    sed -i 's:pm\.max\_children = 5:pm\.max\_children \= 100:g' /usr/local/php/etc/php-fpm.conf
else
    sed -i 's:pm\.max\_children = 5:pm\.max\_children \= 40:g' /usr/local/php/etc/php-fpm.conf
    sed -i 's:pm\.start\_servers = 2:pm\.start\_servers \= 10:g' /usr/local/php/etc/php-fpm.conf
    sed -i 's:pm\.min\_spare\_servers = 1:pm\.min\_spare\_servers \= 10:g' /usr/local/php/etc/php-fpm.conf
    sed -i 's:pm\.max\_spare\_servers = 3:pm\.max\_spare\_servers \= 40:g' /usr/local/php/etc/php-fpm.conf
fi

# modify nginx.conf for php
cp /usr/local/nginx/conf/nginx.conf /usr/local/nginx/conf/nginx.conf.org.bak
sed -i "s:#user\s*nobody;:user www www;:g" /usr/local/nginx/conf/nginx.conf
sed -i '/# pass the PHP scripts to FastCGI server listening on 127.0.0.1:9000/a\location \~ \\.php\$ \{\nroot           html;\nfastcgi_pass   127.0.0.1:9000;\nfastcgi_index  index.php;\nfastcgi_param SCRIPT_FILENAME \$document_root\$fastcgi_script_name;\nfastcgi_param PATH_INFO $fastcgi_path_info;\nfastcgi_param PATH_TRANSLATED $document_root$fastcgi_path_info;\nfastcgi_connect_timeout 60;\nfastcgi_send_timeout    180;\nfastcgi_read_timeout    180;\nfastcgi_buffer_size 128k;\nfastcgi_buffers 4 256k;\nfastcgi_busy_buffers_size 256k;\nfastcgi_temp_file_write_size 256k;\nfastcgi_intercept_errors on;\ninclude        fastcgi_params;\n\}\n' /usr/local/nginx/conf/nginx.conf

cd ../
cp -rf conf/p.php /usr/local/nginx/html/p.php
cp -rf conf/phpinfo.php /usr/local/nginx/html/phpinfo.php

# create nginx vhost dir
mkdir -pv /usr/local/nginx/conf/vhost
sed -i '/# another virtual host using mix of IP-, name-, and port-based configuration/a\include vhost/*.conf;' /usr/local/nginx/conf/nginx.conf