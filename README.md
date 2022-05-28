# asterisk16CentOS7

Turn it on 'macro' application for internal call.

Reboot system after install asterisk for correct install FreePBX.

For protect access in web interfaces FreePBX you can create password on access on server level:

touch /etc/httpd/.htpasswd

htpasswd -c /etc/httpd/.htpasswd USER_NAME

nano /var/www/html/.htaccess     

Add inside file strings:

AuthType Basic
AuthName "Restricted Content"
AuthUserFile /etc/httpd/.htpasswd
Require valid-user
