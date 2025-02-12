sudo wget https://repo.zabbix.com/zabbix/7.0/ubuntu/pool/main/z/zabbix-release/zabbix-release_7.0-2+ubuntu24.04_all.deb
sudo dpkg -i zabbix-release_7.0-2+ubuntu24.04_all.deb
sudo apt update

sudo apt install -y zabbix-server-mysql zabbix-frontend-php zabbix-nginx-conf zabbix-sql-scripts zabbix-agent

sudo mysql -u root <<MYSQL_SCRIPT
create database zabbix character set utf8mb4 collate utf8mb4_bin;
create user zabbix@localhost identified by 'password';
grant all privileges on zabbix.* to zabbix@localhost;
set global log_bin_trust_function_creators = 1;
MYSQL_SCRIPT

zcat /usr/share/zabbix-sql-scripts/mysql/server.sql.gz | mysql --default-character-set=utf8mb4 -uzabbix -p'password' zabbix

sudo mysql -u root <<MYSQL_SCRIPT
set global log_bin_trust_function_creators = 0;
MYSQL_SCRIPT

sudo sed -i "s/^# DBPassword=.*/DBPassword=password/" /etc/zabbix/zabbix_server.conf

sudo sed -i -e 's/# listen 8080;/listen 80;/' -e 's/# server_name example.com;/server_name 192.168.1.215;/' /etc/zabbix/nginx.conf

systemctl restart zabbix-server zabbix-agent nginx php8.3-fpm
systemctl enable zabbix-server zabbix-agent nginx php8.3-fpm
