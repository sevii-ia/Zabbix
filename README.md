# Zabbix Installation Guide

Цей репозиторій містить інструкції для встановлення Zabbix на сервері з Ubuntu 24.04.

## Кроки для встановлення

1. Завантажте та встановіть пакет Zabbix:

   ```bash
   sudo wget https://repo.zabbix.com/zabbix/7.0/ubuntu/pool/main/z/zabbix-release/zabbix-release_7.0-2+ubuntu24.04_all.deb
   sudo dpkg -i zabbix-release_7.0-2+ubuntu24.04_all.deb
   sudo apt update
   ```

2. Встановіть необхідні пакети:

   ```bash
   sudo apt install -y zabbix-server-mysql zabbix-frontend-php zabbix-nginx-conf zabbix-sql-scripts zabbix-agent
   ```

3. Створіть базу даних та користувача для Zabbix:

   ```bash
   sudo mysql -u root <<MYSQL_SCRIPT
   create database zabbix character set utf8mb4 collate utf8mb4_bin;
   create user zabbix@localhost identified by 'password';
   grant all privileges on zabbix.* to zabbix@localhost;
   set global log_bin_trust_function_creators = 1;
   MYSQL_SCRIPT
   ```

4. Імпортуйте початкові SQL-скрипти Zabbix:

   ```bash
   zcat /usr/share/zabbix-sql-scripts/mysql/server.sql.gz | mysql --default-character-set=utf8mb4 -uzabbix -p'password' zabbix
   ```

5. Вимкніть довірчі функції для створення функцій у MySQL:

   ```bash
   sudo mysql -u root <<MYSQL_SCRIPT
   set global log_bin_trust_function_creators = 0;
   MYSQL_SCRIPT
   ```

6. Налаштуйте пароль для бази даних у конфігураційному файлі Zabbix:

   ```bash
   sudo sed -i "s/^# DBPassword=.*/DBPassword=password/" /etc/zabbix/zabbix_server.conf
   ```

7. Налаштуйте конфігурацію Nginx для Zabbix:

   ```bash
   sudo sed -i -e 's/^#\s*listen\s*8080;/listen 80;/' -e 's/^#\s*server_name\s*example.com;/server_name 192.168.1.170;/' /etc/zabbix/nginx.conf
   ```

8. Перезапустіть сервіси:

   ```bash
   systemctl restart zabbix-server zabbix-agent nginx php8.3-fpm
   ```

9. Увімкніть автозапуск служб:

   ```bash
   systemctl enable zabbix-server zabbix-agent nginx php8.3-fpm
   ```

## Після встановлення

1. Ви можете отримати доступ до інтерфейсу Zabbix через веб-браузер, використовуючи адресу вашого сервера (наприклад, http://192.168.1.170).

2. Завершіть налаштування через веб-інтерфейс, вказавши деталі з'єднання з базою даних та інші параметри.

### Примітки

- Замініть `'password'` на ваш фактичний пароль у відповідних командах.
- Налаштування Nginx включає IP-адресу `192.168.1.170`. Змініть її на вашу відповідну IP-адресу.
