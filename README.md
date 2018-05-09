## 一、简介

> 说明： 这是v1最后版本，在v2前会提交lnmp.org下面所有的历史版本以缓存

1. `BoxCore-LNMP` 是一款自动安装`LNMP`服务环境的一键部署工具，包含`Nginx`、`MySQL`和`PHP`
2. 目前仅在CentOS 6.5 minimal 安装（32/64位均可）测试过
3. php的依赖包均通过yum进行安装

## 二、安装和使用

1、安装方法

通过Git下载（推荐）

	yum -y install git
	git clone https://github.com/boxcore/lnmp.git
	cd lnmp && chmod 755 *.sh && dos2unix lnmp.sh && ./lnmp.sh

## 三、联系方式

> Email: [boxcore#live.com](boxcore#live.com) （推荐）  
> Weibo：[@abanet](https://weibo.com/boxcore)  
> Home Page: [Blog](https:/boxcore.github.io/)  

## 四、TODO
> 添加apache支持
