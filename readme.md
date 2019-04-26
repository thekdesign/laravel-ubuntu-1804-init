<p align="center">
  <br>
  <h1>Ubuntu 18.04 版本 Laravel 環境</h1>
  <br>
  <b>環境建置腳本</b>
  <br>
</p>

[參考](https://github.com/summerblue/laravel-ubuntu-init)

## 簡介

適用在 Ubuntu 18.04 的 LNMP 安裝腳本，並設置了中國國內鏡像加速。

請確保所有指令都以 root 帳戶執行，如果登入帳戶不是 root，則需執行 `sudo su -` 切換為 root 帳戶後再下載安裝。

## 軟體列表

* Git
* PHP 7.3
* Nginx
* MySQL
* Sqlite3
* Composer
* Nodejs 10
* Yarn
* Redis
* Beanstalkd
* Memcached

## 可選軟體列表

以下軟體需手動執行安裝腳本：

* Elasticsearch：`./18.04/install_elasticsearch.sh`

## 安裝步驟

```
wget -qO- https://raw.githubusercontent.com/thekdesign/laravel-ubuntu-1804-init/master/download.sh - | bash
```

此腳本會將安裝腳本下載到當前用戶的 Home 目錄下的 `laravel-ubuntu-1804-init` 目錄並且自動執行安裝腳本，在安裝結束後會在螢幕上輸出 Mysql root 帳號的密碼，請妥善保存。

如果當前不是 root 帳戶則不會自動安裝，需要切換到 root 帳戶後執行 `./18.04/install.sh`。

## 日常使用

### 1. 新增 Nginx 配置

```
./18.04/nginx_add_site.sh
```

會提示輸入網站名稱（只能是英文、數字、`-` 和 `_`）、域名（多個域名用空格隔開），確認無誤後會創建對應的 Nginx 配置並重新啟動 Nginx。

### 2. 新增 Mysql 用戶、數據庫

```
./18.04/mysql_add_user.sh
```

會提示輸入 root 密碼，如果錯誤將無法繼續。輸入需要創建的 Mysql 用戶名，以及確認是否需要創建對應用戶名的數據庫。

創建完畢後會將新用戶的密碼輸出到螢幕上，請妥善保存。

### 3. 以 www-data 身份執行命令

本項目提供了一個 `sudowww` 的 `alias`，當需要以 `www-data` 用戶身份執行命令時（如 `git clone 項目`、`php artisan config:cache` 等），可以直接在命令前加上 `sudowww`，同時在原命令兩端加上單引號，如：

```
sudowww 'git clone git@github.com:thekdesign/laravel-ubuntu-1804-init.git'
```

```
sudowww 'php artisan config:cache'
```
