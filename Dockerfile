# Задание 1 - выберем базовый образ
FROM ubuntu:20.04
# Задание 2 - выполняем обновление apt-кеша
RUN apt-get update
# Задание 3 - Обновляем пакеты в контейнере
RUN apt-get upgrade -y
# Задание 4 - Устанавливаем веб-сервер nginx
RUN apt-get install nginx -y --no-install-recommends
# Задание 5 - Очищаем скаченный apt-cache
RUN apt-get clean
# Задание 6 - Удаляем содержимое директории /var/www/
RUN rm -rf /var/www/*
# Задание 7 - Создаем в директории /var/www/ диреторию с именем сайта и папку с картинками
RUN mkdir -p /var/www/my_project/img
# Задание 8 - Помещаем index.html внутрь папки index.html(*) 
COPY index.html /var/www//my_project/
# Задание 9 - Копируем картинку внутрь контейнера
COPY img.jpg /var/www/my_project/img/
# Задание 10 - Задаем рекурсивно на папку /var/www/my_project права "владельцу - читать, писать, исполнять", "группе - читать, исполнять", "остальным - читать исполнять"
RUN chmod -R 755 /var/www/my_project
# Задание 11 - С помощью команды useradd создаю пользователя
RUN useradd -m dariakrylova
# Задание 12 - С помощью команды groupadd сощдаем группу
RUN groupadd dariakrylova_group
# Задание 13 - С помощью команды usermod помещаем пользователя в в группу, которую создали ранее
RUN usermod -a -G dariakrylova_group dariakrylova
# Задание 14 - Рекурсивно присвоить созданного пользователя и группу на папку /var/www/my_project
RUN chown -R dariakrylova:dariakrylova_group /var/www/my_project
# Задание 15, 16, 17
COPY setup-nginx-config.sh /usr/local/bin/setup-nginx-config.sh
RUN chmod +x /usr/local/bin/setup-nginx-config.sh
RUN /usr/local/bin/setup-nginx-config.sh
# Задание 18, 19 - выполняем команды запуска
# docker build -t test .
# И заходим внутрь контейнера в итеративнм режиме и проверяем работоспособность nginx
# docker run -it test /bin/bash
# nginx -t (Все заработало корректно!)
# Задание 20 - По умолчанию порт 8080
# Задание 21 - Задайте в команды запуска веб-сервера.
CMD ["nginx", "-g", "daemon off;"]
