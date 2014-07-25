#!/bin/bash

# Check if user is root
[ $(id -u) != "0" ] && echo "Error: You must be root to run this script" && kill -9 $$
export PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
clear
echo "#######################################################################"
echo "#         LNMP for CentOS/RadHat 5+ Debian 6+ and Ubuntu 12+          #"
echo "#                           Uninstall LNMP                            #"
echo "# For more information Please visit http://lnmp.boxcore.org           #"
echo "#######################################################################"

Uninstall()
{
echo 'Remove MySQL..'
RemoveMySQL
echo 'Remove PHP..'
RemovePHP
echo 'Remove Nginx..'
RemoveNginx
echo "It's done, have fun today!"
}

RemoveMySQL()
{

chkconfig mysql off
[ -e "$mysql_install_dir" ] && service mysql stop && rm -rf /etc/init.d/mysql /etc/my.cnf /etc/ld.so.conf.d/mysql.conf /usr/include/mysql /usr/lib/mysql /var/mysql
sed -i "s@^export.*PATH=/usr/local/mysql/bin:.*@@g" /etc/profile
source /etc/profile  # 同(.  /etc/profile)
}

RemoveNginx()
{
chkconfig nginx off
[ -e "$nginx_install_dir" ] && service nginx stop && rm -rf /etc/rc.d/init.d/nginx /usr/bin/nginx /usr/local/nginx
}

RemovePHP()
{
chkconfig php-fpm off
[ -e "$php_install_dir" ] && service php-fpm stop && rm -rf /usr/local/php/etc/php.ini /usr/local/php/etc/php-fpm.conf /etc/rc.d/init.d/php-fpm /usr/local/php
}

cat > ./lnmp_file_list.tmp<<EOF
/usr/local/nginx
/usr/local/mysql
/usr/local/php

/etc/rc.d/init.d/nginx
/usr/bin/nginx

/var/mysql/data
/etc/my.cnf
/etc/init.d/mysql
/etc/profile [only modify]
/etc/ld.so.conf.d/mysql.conf
/usr/lib/mysql

/usr/local/php/etc/php.ini
/usr/local/php/etc/php-fpm.conf
/etc/rc.d/init.d/php-fpm
EOF

mysql_install_dir='/usr/local/mysql'
nginx_install_dir='/usr/local/nginx'
php_install_dir='/usr/local/php'

echo 
echo -e "\033[31mYou will uninstall LNMP, Please backup your configure files and DB data! \033[0m"
echo 
echo -e "\033[33mThe following directory or files will be remove: \033[0m"
for D in `cat ./lnmp_file_list.tmp` 
do
    [ -e "$D" ] && echo $D
done

while :
do
        echo
        read -p "Do you want to uninstall LNMP? [y/n]: " uninstall_yn
        if [ "$uninstall_yn" != 'y' -a "$uninstall_yn" != 'n' ];then
                echo -e "\033[31minput error! Please only input 'y' or 'n'\033[0m"
        else
                break
        fi
done

[ "$uninstall_yn" == 'y' ] && Uninstall 