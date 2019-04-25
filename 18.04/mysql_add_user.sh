#!/bin/bash

CURRENT_DIR=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
source ${CURRENT_DIR}/../common/common.sh

read -r -p "請輸入 mysql root 密碼：" MYSQL_ROOT_PASSWORD

mysql --user="root" --password="${MYSQL_ROOT_PASSWORD}" -e "quit" >> ${LOG_PATH} 2>&1 || {
    ansi -n --bold --bg-red "密碼不正確"
    exit 1
}

read -r -p "請輸入要新建的用戶名稱：" MYSQL_NORMAL_USER

[[ $MYSQL_NORMAL_USER =~ ^[a-zA-Z\0-9_\-]+$ ]] || {
    ansi -n --bold --bg-red "用戶名包含非法字元"
    exit 1
}

MYSQL_NORMAL_USER_PASSWORD=`random_string`

read -r -p "是否創建同名數據庫並賦予權限？[y/N] " response
case "$response" in
    [yY][eE][sS]|[yY])
        CREATE_DB=1
        ;;
    *)
        CREATE_DB=0
        ;;
esac

mysql --user="root" --password="${MYSQL_ROOT_PASSWORD}" -e "CREATE USER '${MYSQL_NORMAL_USER}' IDENTIFIED BY '${MYSQL_NORMAL_USER_PASSWORD}';" >> ${LOG_PATH} 2>&1

ansi -n --bold --green "用戶創建成功";

ansi --green --bold "用戶名："; ansi -n --bg-yellow --black ${MYSQL_NORMAL_USER}
ansi --green --bold "密碼："; ansi -n --bg-yellow --black ${MYSQL_NORMAL_USER_PASSWORD}

if [[ CREATE_DB -eq 1 ]]; then
    DATABASE_NAME=${MYSQL_NORMAL_USER}
    mysql --user="root" --password="${MYSQL_ROOT_PASSWORD}" -e "CREATE DATABASE \`${DATABASE_NAME}\`;" >> ${LOG_PATH} 2>&1
    mysql --user="root" --password="${MYSQL_ROOT_PASSWORD}" -e "GRANT ALL ON \`${DATABASE_NAME}\`.* TO '${MYSQL_NORMAL_USER}';" >> ${LOG_PATH} 2>&1
    mysql --user="root" --password="${MYSQL_ROOT_PASSWORD}" -e "FLUSH PRIVILEGES;" >> ${LOG_PATH} 2>&1
fi

ansi -n --bold --green "數據庫 ${DATABASE_NAME} 創建成功";
