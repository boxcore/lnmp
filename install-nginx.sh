#!/bin/bash

yum install openssl openssl-devel

# install pcre for nginx
tar zxvf pcre-8.34.tar.gz
cd pcre-8.34/
./configure
make && make install
cd ../

# nginx报错解决： Starting nginx: /usr/local/nginx/sbin/nginx: error while loading shared libraries: libpcre.so.1: cannot open shared object file: No such file or directory
ln -s /usr/local/lib/libpcre.so.1 /lib
ldconfig

# install nginx
tar zxvf nginx-1.4.4.tar.gz
cd nginx-1.4.4/
./configure --user=www --group=www --prefix=/usr/local/nginx --with-http_stub_status_module --with-http_ssl_module --with-http_gzip_static_module --with-pcre
make && make install
cd ../

# install nginx service shell
rm -rf /etc/rc.d/init.d/nginx
cp -rf conf/nginx /etc/rc.d/init.d/nginx

chmod 775 /etc/rc.d/init.d/nginx
chkconfig nginx on
/etc/rc.d/init.d/nginx restart
service nginx restart

ln -s /usr/local/nginx/sbin/nginx /usr/bin/nginx

mv -f /usr/local/nginx/conf/nginx.conf /usr/local/nginx/conf/nginx.conf.org.bak
cp conf/nginx.conf /usr/local/nginx/conf/nginx.conf
# cp conf/www-conf /home/www/conf


# mkdir -p /home/www/{default,logs,logs/nginx,logs/php}
# touch /home/www/logs/nginx/error.log
# chmod +w /home/www/default
# chmod 777 /home/www/logs
# chown -R www:www /home/www
