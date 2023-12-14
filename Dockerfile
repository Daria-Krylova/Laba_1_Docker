# Выбираем Alpine Linux (более легковесный образ)
FROM alpine:latest

# Устанавливаем nginx
RUN apk update && apk add nginx && \
    rm -rf /var/cache/apk/* && \
    mkdir -p /run/nginx && \
    mkdir -p /var/www/my_project/img

# Копируем файлы проекта
COPY index.html /var/www/my_project/
COPY img.jpg /var/www/my_project/img/

# Задаем права доступа и пользователя
RUN chmod -R 755 /var/www/my_project && \
    adduser -D dariakrylova && \
    addgroup dariakrylova_group && \
    addgroup dariakrylova dariakrylova_group && \
    chown -R dariakrylova:dariakrylova_group /var/www/my_project
    
# Настраиваем конфигурацию nginx
RUN sed -i 's/\/var\/www\/localhost\/htdocs/\/var\/www\/my_project/g' /etc/nginx/http.d/default.conf && \
    nginx_user_file=$(grep -rl 'user .*;' /etc/nginx/) && \
     sed -i 's/user .*;/user dariakrylova dariakrylova_group;/g' "$nginx_user_file"
    
# Задаем команду запуска
CMD ["nginx", "-g", "daemon off;"]
