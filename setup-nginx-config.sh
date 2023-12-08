#!/bin/bash

# Залание 15 -  Заменить подстроку в файле /etc/nginx/sites-enabled/default
sed -i 's/\/var\/www\/html/\/var\/www\/my_project/g' /etc/nginx/sites-enabled/default

# Задание 16 - Найти файл, в котором задается пользователь (user), от которого запускается nginx
nginx_user_file=$(grep -rl 'user .*;' /etc/nginx/)

# Задание 17 -  Заменить пользователя в найденном файле на вашего пользователя
sed -i 's/user .*;/user dariakrylova;/g' "$nginx_user_file"

