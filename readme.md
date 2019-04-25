<p align="center">
  <br>
  <b>測試專案</b>
  <br>
</p>

[參考](https://github.com/summerblue/laravel-ubuntu-init)

嘗試製作

## 简介

適用在 Ubuntu 18.04 的 LNMP 安裝腳本，並設置了中國國內鏡像加速。

請確保所有指令都以 root 帳戶執行，如果登入帳戶不是 root，則需執行 `sudo su -` 切換為 root 帳戶後再下載安裝。

## 软件列表

* Git
* PHP 7.3
* Nginx
* MySQL
* Sqlite3
* Composer
* Nodejs 8
* Yarn
* Redis
* Beanstalkd
* Memcached

## 可选软件列表

以下软件需手动执行安装脚本：

* Elasticsearch：`./18.04/install_elasticsearch.sh`

## 安装步骤

```
wget -qO- https://raw.githubusercontent.com/thekdesign/laravel-ubuntu-1804-init/master/download.sh - | bash
```

此脚本会将安装脚本下载到当前用户的 Home 目录下的 `laravel-ubuntu-1804-init` 目录并自动执行安装脚本，在安装结束之后会在屏幕上输出 Mysql root 账号的密码，请妥善保存。

如果当前不是 root 账户则不会自动安装，需要切换到 root 账户后执行 `./18.04/install.sh`。

## 日常使用

### 1. 新增 Nginx 站点

```
./18.04/nginx_add_site.sh
```

会提示输入站点名称（只能是英文、数字、`-` 和 `_`）、域名（多个域名用空格隔开），确认无误后会创建对应的 Nginx 配置并重启 Nginx。

### 2. 新增 Mysql 用户、数据库

```
./16.04/mysql_add_user.sh
```

会提示输入 root 密码，如果错误将无法继续。输入需要创建的 Mysql 用户名，以及确认是否需要创建对应用户名的数据库。

创建完毕之后会将新用户的密码输出到屏幕上，请妥善保存。

### 3. 以 www-data 身份执行命令

本项目提供了一个 `sudowww` 的 `alias`，当需要以 `www-data` 用户身份执行命令时（如 `git clone 项目`、`php artisan config:cache` 等），可以直接在命令前加上 `sudowww`，同时在原命令两端加上单引号，如：

```
sudowww 'php artisan config:cache'
```
