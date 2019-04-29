#!/bin/bash

CURRENT_DIR=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
source ${CURRENT_DIR}/../common/common.sh

[ $(id -u) != "0" ] && { ansi -n --bold --bg-red "請用 root 帳戶執行本腳本"; exit 1; }

read -r -p "請輸入項目名稱：" project

[[ $project =~ ^[A-Za-z0-9_\-\.]+$ ]] || {
    ansi -n --bold --bg-red "項目包含非法字元"
    exit 1
}

read -r -p "請輸入網站域名（多個域名用空格隔開）：" domains

project_dir="/var/www/html/${project}"

ansi -n --bold --green "域名列表：${domains}"
ansi -n --bold --green "項目名稱：${project}"
ansi -n --bold --green "項目目錄：${project_dir}"

read -r -p "是否確認？ [y/N] " response
case "$response" in
    [yY][eE][sS]|[yY])
        ;;
    *)
        ansi -n --bold --bg-red "用戶取消"
        exit 1
        ;;
esac

cat ${CURRENT_DIR}/nginx_site_conf.tpl |
    sed "s|{{domains}}|${domains}|g" |
    sed "s|{{project}}|${project}|g" |
    sed "s|{{project_dir}}|${project_dir}|g" > /etc/nginx/sites-available/${project}.conf

ln -sf /etc/nginx/sites-available/${project}.conf /etc/nginx/sites-enabled/${project}.conf

ansi -n --bold --green "配置文件創建成功";

mkdir -p ${project_dir} && chown -R ${WWW_USER}.${WWW_USER_GROUP} ${project_dir}

systemctl restart nginx.service

ansi -n --bold --green "nginx 重啟成功";
