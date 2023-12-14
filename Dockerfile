# Выбираем стандартный базовый образ (можно еще обновить образ)
FROM ubuntu:20.04

# Объединяем команды для уменьшения количества слоев и очистки кэша
RUN apt-get update && apt-get upgrade -y && \
    apt-get install nginx -y --no-install-recommends && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Копируем только необходимые файлы
COPY index.html /var/www/my_project/
COPY img.jpg /var/www/my_project/img/
COPY setup-nginx-config.sh /usr/local/bin/

# Выполняем остальные настройки
RUN mkdir -p /var/www/my_project/img && \
    chmod -R 755 /var/www/my_project && \
    useradd -m dariakrylova && \
    groupadd dariakrylova_group && \
    usermod -a -G dariakrylova_group dariakrylova && \
    chown -R dariakrylova:dariakrylova_group /var/www/my_project && \
    chmod +x /usr/local/bin/setup-nginx-config.sh && \
    /usr/local/bin/setup-nginx-config.sh

# Задаем команду запуска
CMD ["nginx", "-g", "daemon off;"]
