#!/bin/bash
# This script run nginx on startup
clear
echo "========================================================================="
echo "LNMP v0.0.1 for VPS  Written by Licess "
echo "========================================================================="
echo ""
echo "For more information please visit http://blog.licess.cn/lnmp/"
echo ""
echo "===================add nginx and php-cgi on startup======================"
echo "ulimit -SHn 51200" >>/etc/rc.local
echo "/usr/local/php/sbin/php-fpm start" >>/etc/rc.local
echo "/usr/local/nginx/sbin/nginx" >>/etc/rc.local
echo "=================add nginx and php-cgi on startup finished==============="