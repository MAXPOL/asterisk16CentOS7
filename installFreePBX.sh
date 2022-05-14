#!/bin/bash
yum -y install epel-release
yum install http://rpms.remirepo.net/enterprise/remi-release-7.rpm -y
yum install yum-utils -y
yum-config-manager --enable remi-php72
yum update -y
wget http://mirror.freepbx.org/modules/packages/freepbx/freepbx-15.0-latest.tgz
tar xvfz freepbx-*.tgz
cd freepbx
systemctl start mariadb
./start_asterisk start
./install -n
echo "include manager_additional.conf" >> /etc/asterisk/manager.conf
echo "include manager_custom.conf" >> /etc/asterisk/manager.conf
systemctl restart httpd
