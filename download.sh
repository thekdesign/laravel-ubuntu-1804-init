#!/bin/bash

{ # this ensures the entire script is downloaded #

lsb_release -d | grep 'Ubuntu' >& /dev/null
[[ $? -ne 0 ]] && { echo "僅支援 Ubuntu 18.04 系統"; exit 1; }

DISTRO=$(lsb_release -c -s)
[[ ${DISTRO} -ne "bionic" ]] && { echo "僅支援 Ubuntu 18.04 系統"; exit 1; }

green="\e[1;32m"
nc="\e[0m"

echo -e "${green}===> 開始下載...${nc}"
cd $HOME
wget -q https://github.com/thekdesign/laravel-ubuntu-1804-init/archive/master.tar.gz -O laravel-ubuntu-1804-init.tar.gz
rm -rf laravel-ubuntu-1804-init
tar zxf laravel-ubuntu-1804-init.tar.gz
mv laravel-ubuntu-1804-init-master laravel-ubuntu-1804-init
rm -f laravel-ubuntu-1804-init.tar.gz
echo -e "${green}===> 下載完畢${nc}"
echo ""
echo -e "${green}安裝腳本位於： ${HOME}/laravel-ubuntu-1804-init${nc}"

[ $(id -u) != "0" ] && {
    source ${HOME}/laravel-ubuntu-1804-init/common/ansi.sh
    ansi -n --bold --bg-yellow --black "當前帳戶並非 root，請用 root 帳戶執行安裝腳本（使用命令：sudo su - 切換為 root）"
} || {
    bash ./laravel-ubuntu-1804-init/18.04/install.sh
}

cd - > /dev/null
} # this ensures the entire script is downloaded #
