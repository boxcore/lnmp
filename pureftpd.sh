#!/bin/bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

# Check if user is root
if [ $(id -u) != "0" ]; then
    printf "Error: You must be root to run this script!\n"
    exit 1
fi
clear
printf "=========================================================================\n"
printf "Pureftpd for LNMP V0.4  ,  Written by Licess \n"
printf "=========================================================================\n"
printf "LNMP is a tool to auto-compile & install Nginx+MySQL+PHP on Linux \n"
printf "This script is a tool to install pureftpd for lnmp \n"
printf "\n"
printf "For more information please visit http://www.lnmp.org \n"
printf "\n"
printf "Usage: ./pureftpd.sh \n"
printf "=========================================================================\n"
cur_dir=$(pwd)

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
	echo "Press any key to start install Pure-FTPd..."
	char=`get_char`

wget -c http://soft.vpser.net/ftp/pure-ftpd/pure-ftpd-1.0.29.tar.gz
wget -c http://soft.vpser.net/ftp/pure-ftpd/User_manager_for-PureFTPd_v2.1_CN.zip

tar zxvf pure-ftpd-1.0.29.tar.gz
cd pure-ftpd-1.0.29/
./configure --prefix=/usr/local/pureftpd CFLAGS=-O2 \
--with-mysql=/usr/local/mysql \
--with-quotas \
--with-cookie \
--with-virtualhosts \
--with-virtualroot \
--with-diraliases \
--with-sysquotas \
--with-ratios \
--with-altlog \
--with-paranoidmsg \
--with-shadow \
--with-welcomemsg  \
--with-throttling \
--with-uploadscript \
--with-language=simplified-chinese

make && make install

cp configuration-file/pure-config.pl /usr/local/pureftpd/sbin/
chmod 755 /usr/local/pureftpd/sbin/pure-config.pl
cp $cur_dir/conf/pureftpd-mysql.conf /usr/local/pureftpd/
cp $cur_dir/conf/pure-ftpd.conf /usr/local/pureftpd/

#Install GUI User manager for PureFTPd
cd $cur_dir
unzip User_manager_for-PureFTPd_v2.1_CN.zip
mv ftp /home/wwwroot/
chmod 777 -R /home/wwwroot/ftp/
chown www -R /home/wwwroot/ftp/

printf "Now you must enter http://youdomain.com/ftp/install.php in you Web Browser to install User manager for PureFTPd\n"
printf "Start Pure-FTPd...\n"
./pureftpd start

cd $cur_dir
cp pureftpd /root/pureftpd
chmod +x /root/pureftpd

clear
printf "Install Pure-FTPd completed,enjoy it!\n"
printf "Now you must enter http://youdomain.com/ftp/install.php in you Web Browser to install User manager for PureFTPd\n"
printf "=======================================================================\n"
printf "Install Pure-FTPd for LNMP V0.4  ,  Written by Licess \n"
printf "=======================================================================\n"
printf "LNMP is a tool to auto-compile & install Nginx+MySQL+PHP on Linux \n"
printf "This script is a tool to install Pure-FTPd for lnmp \n"
printf "\n"
printf "For more information please visit http://www.lnmp.org \n"
printf "=======================================================================\n"