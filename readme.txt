LNMP��һ������CentOS��д��Nginx��PHP��MySQL��phpMyAdmin��eAceleratorһ����װ����������VPS���������������ɵİ�װLNMP���������� 

LNMP Ver0.1����汾˵����
Nginx��0.7.61
PHP��5.2.10
MySQL��5.1.35

ʹ��˵��: 
���ϵͳԤ��װApahce�����Ѿ���װApache����������yum remove httpd��ɾ��Apache��
��½Linux,����LNMPѹ����������ѹ. (һЩ���ѿ��ܲ�֪����ôŪ����½VPS����������

���ɰ�װ����װ��
ִ������ wget http://blog.licess.cn/uploads/lnmp/lnmp0.1.tar.gz ,��lnmp0.1.tar.gz���ص�VPS�У�ִ�� tar zxvf lnmp0.1.tar.gz ��ѹLNMPһ����װ��)��
ִ��chmod +x install.sh ,���ִ��Ȩ�ޡ�
Ȼ����ִ��./install.sh ������Ҫ�󶨵��������س��󡣳�����Զ���װ����Nginx��PHP��MySQL��phpMyAdmin��eAcelerator�⼸������� 

��װ����װ��
ִ������ wget http://blog.licess.cn/uploads/lnmp/lnmp0.1.zip ,��lnmp0.1.zip���ص�VPS�У�ִ�� unzip lnmp0.1.zip ��ѹLNMPһ����װ��)��
ִ��chmod +x install.sh ,���ִ��Ȩ�ޡ�
Ȼ����ִ��./install.sh ������Ҫ�󶨵��������س��󡣳�����Զ���װ����Nginx��PHP��MySQL��phpMyAdmin��eAcelerator�⼸�������

����װ·���� 
MySQL :   /usr/local/mysql 
PHP :     /usr/local/php 
Nginx :   /usr/local/nginx 
PHPMyAdmin /web/www/phpmyadmin 
WebĿ¼    /web/www 

��Nginx�������ֶ�ִ�� /root/run.sh ��Nginx������ �������Զ����п������� LNMPĿ¼����� startup.sh �ļ����ɡ� 
opt.sh Ϊ�Ż��ļ�������ڴ�С��128MB����ͨ��ִ�� ./opt.sh ���swap���������޸�ʱ��Ϊ��8����ע������һ�������е�VPS�϶��������swap������swvps�����ԣ�����û�в��ԡ� 

ͨ�������⼸�����Ӳ鿴phpinfo�͹���MySQL 
phpinfo    http://domain.name/phpinfo.php 
phpMyAdmin http://domain.name/phpmyadmin
PHP̽�룺  http://domain.name/prober.php

�˰汾Ϊ���԰汾���Ѿ���SWVPS��DiaVPS��RASHOST��thenynoc.com��VMware CentOS��С����װ �ϲ��Գɹ��� 

��ʾվ�㣺http://www.vpser.net
���κ������뵽 http://blog.licess.cn/lnmp/ �� 

QQ����Ⱥ��12327692  
������̳�� http://bbs.vpser.net
���ص�ַ��
���������(��������Ѵ������)��http://blog.licess.cn/uploads/lnmp/lnmp0.1.tar.gz
��װ��(�����Զ�������վ����)��http://blog.licess.cn/uploads/lnmp/lnmp0.1.zip
������ʾ��Linux�²�����ע���Сд��