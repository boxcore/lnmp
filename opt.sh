clear
echo "========================================================================="
echo "LNMP v0.0.1 for VPS  Written by Licess "
echo "========================================================================="
echo ""
echo "For more information please visit http://blog.licess.cn/lnmp/"
echo ""
echo "============================setup swap=================================="
cd /var/
dd if=/dev/zero of=swapfile bs=1024 count=262144
/sbin/mkswap swapfile
/sbin/swapon swapfile

echo "/var/swapfile swap swap defaults 0 0" >>/etc/fstab
echo "============================set zoneinfo================================="
cp -f /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
echo "setup swap & zoneinfo fininshed."
echo ""
echo "========================================================================="