#!/bin/bash

# Копируем файл 000-default.conf
sudo cp /Apache_MySQL_2_Ubuntu/000-default.conf /etc/apache2/sites-available/000-default.conf

# Создаём папку /var/www/html/apache2
sudo mkdir /var/www/html/apache2

# Импортируем файл
sudo mv index.html /var/www/html/apache2/

# Перезапускаем Apache
sudo systemctl reload apache2

# Копируем файл mysqld.cnf
sudo cp /Apache_MySQL_2_Ubuntu/mysqld.cnf /etc/mysql/mysql.conf.d/mysqld.cnf

# Перезапускаем MySQL
systemctl restart mysql

# Подключаем пользователя
mysql -u root -p -e "CHANGE REPLICATION SOURCE TO SOURCE_HOST='192.168.1.36', SOURCE_USER='repl', SOURCE_PASSWORD='oTUSlave#2020', SOURCE_AUTO_POSITION = 1, GET_SOURCE_PUBLIC_KEY = 1;"

# Запуск реплики
mysql -u root -p -e "START REPLICA;"