#!/bin/sh

wget http://soft.vpser.net/ftp/pure-ftpd/pure-ftpd-1.0.22.tar.gz
wget http://soft.vpser.net/ftp/pure-ftpd/User_manager_for-PureFTPd_v2.1_CN.zip
tar zxvf pure-ftpd-1.0.22.tar.gz
cd pure-ftpd-1.0.22

./configure --prefix=/usr/local/pureftpd CFLAGS=-O2 \
--with-mysql=/usr/local/mysql \
--with-quotas \
--with-cookie \
--with-virtualhosts \
--with-virtualroot \
--with-diraliases \
--with-sysquotas \
--with-ratios \
--with-ftpwho \
--with-altlog \
--with-paranoidmsg \
--with-shadow \
--with-welcomemsg  \
--with-throttling \
--with-uploadscript \
--with-language=simplified-chinese
make
make install clean

mkdir -p /web/www
chmod 711 /web/www
chown ftp /web/www

cp configuration-file/pure-config.pl /usr/local/pureftpd/sbin/
chmod 700 /usr/local/pureftpd/sbin/pure-config.pl
cp ../conf/pureftpd-mysql.conf /usr/local/pureftpd/
chmod 600 /usr/local/pureftpd/pureftpd-mysql.conf
cp ../conf/pure-ftpd.conf /usr/local/pureftpd/
chmod 600 /usr/local/pureftpd/pure-ftpd.conf
chmod 4711 /usr/local/pureftpd/sbin/pure-ftpwho

#pureftpd-start
echo "/usr/local/pureftpd/sbin/pure-config.pl /usr/local/pureftpd/pure-ftpd.conf" >> /usr/local/pureftpd/sbin/pureftpd-start
chmod 700 /usr/local/pureftpd/sbin/pureftpd-start
ln -sf /usr/local/pureftpd/sbin/pureftpd-start /pureftpd-start
echo "/pureftpd-start" >> '/etc/rc.local'

#pureftpd-stop
echo "killall pure-ftpd" >> /usr/local/pureftpd/sbin/pureftpd-stop
chmod 700 /usr/local/pureftpd/sbin/pureftpd-stop
ln -sf /usr/local/pureftpd/sbin/pureftpd-stop /pureftpd-stop

#pureftpd-restart
echo "/usr/local/pureftpd/sbin/pureftpd-stop" >> /usr/local/pureftpd/sbin/pureftpd-restart
echo "/usr/local/pureftpd/sbin/pureftpd-start" >> /usr/local/pureftpd/sbin/pureftpd-restart
chmod 700 /usr/local/pureftpd/sbin/pureftpd-restart
ln -sf /usr/local/pureftpd/sbin/pureftpd-restart /pureftpd-restart

#Install User_manager_for-PureFTPd
cd ../
unzip User_manager_for-PureFTPd_v2.1_CN.zip
cp -a ftp /web/www/

echo "Now you must enter http://youdomain.com/ftp/install.php in you Web Browser to install User manager for PureFTPd"


/pureftpd-start