#!/bin/bash

echo "Enter new password database:"
read passworddb

yum update -y

sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config

yum install epel-release -y

yum groupinstall core base "Development Tools" -y

yum install mariadb-server yum-utils iksemel-devel dnf httpd -y

rpm -Uhv http://rpms.remirepo.net/enterprise/remi-release-7.rpm
yum-config-manager --enable remi-php71

yum install wget php php-pear php-cgi php-common php-curl php-mbstring php-gd php-mysql php-gettext php-bcmath php-zip php-xml php-imap php-json php-process php-snmp -y

dnf --enablerepo=powertools install speexdsp-devel

sed -i 's/^\(User\|Group\).*/\1 asterisk/' /etc/httpd/conf/httpd.conf
sed -i 's/AllowOverride None/AllowOverride All/' /etc/httpd/conf/httpd.conf
sed -i 's/upload_max_filesize = 2M/upload_max_filesize = 120M/g' /etc/php.ini

curl -sL https://rpm.nodesource.com/setup_10.x | bash -
yum clean all && sudo yum makecache fast

yum install gcc-c++ make nodejs -y

systemctl start mariadb
systemctl enable mariadb

mysql_secure_installation <<EOF

y
$passworddb
$passworddb
y
n
y
y
EOF

cd /
wget http://downloads.asterisk.org/pub/telephony/asterisk/asterisk-16-current.tar.gz
tar zxvf asterisk-*.tar.gz
cd asterisk*

contrib/scripts/install_prereq install
contrib/scripts/get_mp3_source.sh
./configure --with-pjproject-bundled --with-jansson-bundled --with-crypto --with-ssl=ssl --with-srtp
make menuselect

make
make install
make config
make samples
ldconfig

sed -i 's/ASTARGS=""/ASTARGS="-U asterisk"/g' /usr/sbin/safe_asterisk

useradd -m asterisk
chown asterisk.asterisk /var/run/asterisk
chown -R asterisk.asterisk /etc/asterisk
chown -R asterisk.asterisk /var/{lib,log,spool}/asterisk
chown -R asterisk.asterisk /usr/lib/asterisk

systemctl enable httpd
systemctl start httpd

systemctl start asterisk
systemctl enable asterisk

firewall-cmd --permanent --zone=public --add-port=5060/tcp --add-port=5060/udp
firewall-cmd --permanent --zone=public --add-port=5061/tcp --add-port=5061/udp
firewall-cmd --permanent --zone=public --add-port=4569/tcp --add-port=4569/udp
firewall-cmd --permanent --zone=public --add-port=5038/tcp --add-port=5038/udp
firewall-cmd --permanent --zone=public --add-port=5038/tcp --add-port=5038/udp
firewall-cmd --permanent --zone=public --add-port=10000-20000/udp
firewall-cmd --reload

clear

systemctl status asterisk
