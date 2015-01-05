#!/bin/bash


#set mysql root password
    echo $hr
    mysqlrootpwd="root"
    echo "Please input the root password of mysql:"
    read -p "(Default password: root):" mysqlrootpwd
    if [ "$mysqlrootpwd" = "" ]; then
        mysqlrootpwd="root"
    fi
    echo $hr
    echo "MySQL root password:$mysqlrootpwd"
    echo $hr


# yum install mysql dependent packages
yum -y install cmake ncurses ncurses-devel bison

# Add mysql user and document
mkdir -pv /var/mysql/data
groupadd -r mysql
useradd -g mysql -r -s /bin/false -M -d /var/mysql/data mysql
chown mysql:mysql /var/mysql/data

# Compile and install mysql
tar -zxf mysql-5.5.35.tar.gz
cd mysql-5.5.35
cmake . -DCMAKE_INSTALL_PREFIX=/usr/local/mysql -DMYSQL_DATADIR=/var/mysql/data -DSYSCONFDIR=/etc -DWITH_MYISAM_STORAGE_ENGINE=1 -DWITH_INNOBASE_STORAGE_ENGINE=1 -DWITH_ARCHIVE_STORAGE_ENGINE=1 -DWITH_BLACKHOLE_STORAGE_ENGINE=1 -DENABLED_LOCAL_INFILE=1 -DDEFAULT_CHARSET=utf8 -DDEFAULT_COLLATION=utf8_general_ci -DEXTRA_CHARSETS=utf8 -DMYSQL_TCP_PORT=3306 -DMYSQL_USER=mysql -DMYSQL_UNIX_ADDR=/tmp/mysql.sock -DWITH_SSL=yes -DWITH_PARTITION_STORAGE_ENGINE=1 -DINSTALL_PLUGINDIR=/usr/local/mysql/plugin -DWITH_DEBUG=0
make && make install

# setting mysql conf
mv -f /etc/my.cnf /etc/my.cnf.bak
cp -rf /usr/local/mysql/support-files/my-medium.cnf /etc/my.cnf
sed '/skip-external-locking/i\datadir = /var/mysql/data' -i /etc/my.cnf
sed -i 's:#innodb:innodb:g' /etc/my.cnf
sed -i 's:/usr/local/mysql/data:/var/mysql/data:g' /etc/my.cnf

# install mysql data
chmod 755 /usr/local/mysql/scripts/mysql_install_db
/usr/local/mysql/scripts/mysql_install_db --defaults-file=/etc/my.cnf --basedir=/usr/local/mysql --datadir=/var/mysql/data --user=mysql
# chown -R mysql /usr/local/mysql/var  #if mysql data path in /usr/local/mysql then use it!
chgrp -R mysql /usr/local/mysql/.

# add mysql server to system
cp /usr/local/mysql/support-files/mysql.server /etc/init.d/mysql
chmod 755 /etc/init.d/mysql
chkconfig mysql on
echo 'export PATH=/usr/local/mysql/bin:$PATH' >> /etc/profile

# ? how it work?
cat > /etc/ld.so.conf.d/mysql.conf<<EOF
/usr/local/mysql/lib
/usr/local/lib
EOF
ldconfig

# add mysql shell to system
ln -s /usr/local/mysql/lib/mysql /usr/lib/mysql
ln -s /usr/local/mysql/include/mysql /usr/include/mysql
if [ -d "/proc/vz" ];then
ulimit -s unlimited
fi
/etc/init.d/mysql start
ln -s /usr/local/mysql/bin/mysql /usr/bin/mysql
ln -s /usr/local/mysql/bin/mysqldump /usr/bin/mysqldump
ln -s /usr/local/mysql/bin/myisamchk /usr/bin/myisamchk
ln -s /usr/local/mysql/bin/mysqld_safe /usr/bin/mysqld_safe

# setting mysql root password
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

# done for mysql install, enjoy it!
/etc/init.d/mysql restart
/etc/init.d/mysql stop
echo "============================MySQL 5.5.35 install completed========================="

