# asterisk16CentOS7

Warning ! Attention ! Maximum protect you voip server otherwise you lose many money !

---
---
---

Turn it on 'macro' application for internal call.


---

Reboot system after install asterisk for correct install FreePBX.

---

For activate work 'chan_sip' you can open 'settings'->'advanced settings' and change string 'SIP Channel Driver' setup parametr on 'BOTH'.

---

For protect access in web interfaces FreePBX you can create password on access on server level:

touch /etc/httpd/.htpasswd

htpasswd -c /etc/httpd/.htpasswd USER_NAME

nano /var/www/html/.htaccess     

Add inside file strings:

AuthType Basic

AuthName "Restricted Content"

AuthUserFile /etc/httpd/.htpasswd

Require valid-user

---

IVR

For activate IVR menu you open 'Admin'->'Module Admin' and press button 'Check online' in list download select module IVR.

---

Settings SIP Trunk

OUTGOING

host=ADDRESS_YOU_VOIP_PROVIDER

context=from-trunk

insecure=port,invite

type=peer

username=LOGIN

defaultuser=LOGIN

secret=PASSWORD

fromuser=LOGIN

fromdomain=ADDRESS_YOU_VOIP_PROVIDER

qualify=yes

nat=auto_force_rport,auto_comedia


INCOMING

LOGIN:PASSWORD@ADDRESS_VOIP_SERVER_PROVIDER/NUMBER_PHONE
