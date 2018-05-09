LNMP是一个基于CentOS编写的Nginx、PHP、MySQL、phpMyAdmin、eAcelerator一键安装包。可以在VPS、独立主机上轻松的安装LNMP生产环境。 

LNMP Ver0.1软件版本说明：
Nginx：0.7.61
PHP：5.2.10
MySQL：5.1.35

使用说明: 
如果系统预安装Apahce或你已经安装Apache，请先运行yum remove httpd，删除Apache！
登陆Linux,下载LNMP压缩包，并解压. (一些朋友可能不知道怎么弄，登陆VPS或者主机，

集成安装包安装：
执行命令 wget http://blog.licess.cn/uploads/lnmp/lnmp0.1.tar.gz ,将lnmp0.1.tar.gz下载到VPS中，执行 tar zxvf lnmp0.1.tar.gz 解压LNMP一键安装包)。
执行chmod +x install.sh ,添加执行权限。
然后再执行./install.sh ，输入要绑定的域名，回车后。程序会自动安装编译Nginx、PHP、MySQL、phpMyAdmin、eAcelerator这几个软件。 

安装包安装：
执行命令 wget http://blog.licess.cn/uploads/lnmp/lnmp0.1.zip ,将lnmp0.1.zip下载到VPS中，执行 unzip lnmp0.1.zip 解压LNMP一键安装包)。
执行chmod +x install.sh ,添加执行权限。
然后再执行./install.sh ，输入要绑定的域名，回车后。程序会自动安装编译Nginx、PHP、MySQL、phpMyAdmin、eAcelerator这几个软件。

程序安装路径： 
MySQL :   /usr/local/mysql 
PHP :     /usr/local/php 
Nginx :   /usr/local/nginx 
PHPMyAdmin /web/www/phpmyadmin 
Web目录    /web/www 

让Nginx开机后手动执行 /root/run.sh 后Nginx会运行 ，开机自动运行可以运行 LNMP目录下面的 startup.sh 文件即可。 
opt.sh 为优化文件，如果内存小于128MB可以通过执行 ./opt.sh 添加swap分区，并修改时区为东8区。注：并不一定在所有的VPS上都可以添加swap分区，swvps不可以，其他没有测试。 

通过下面这几个链接查看phpinfo和管理MySQL 
phpinfo    http://domain.name/phpinfo.php 
phpMyAdmin http://domain.name/phpmyadmin
PHP探针：  http://domain.name/prober.php

此版本为测试版本，已经在SWVPS、DiaVPS、RASHOST、thenynoc.com、VMware CentOS最小化安装 上测试成功。 

演示站点：http://www.vpser.net
有任何问题请到 http://blog.licess.cn/lnmp/ 。 

QQ交流群：12327692  
交流论坛： http://bbs.vpser.net
下载地址：
集成软件包(所需软件已打包在内)：http://blog.licess.cn/uploads/lnmp/lnmp0.1.tar.gz
安装包(程序自动链接网站下载)：http://blog.licess.cn/uploads/lnmp/lnmp0.1.zip
友情提示：Linux下操作请注意大小写。