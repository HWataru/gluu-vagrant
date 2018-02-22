#!/bin/sh
cp -p /vagrant/tmp/setup.properties /opt/gluu-server-$version/install/community-edition-setup/

while [ -z "`netstat -antlp | grep 60022 | grep LISTEN`" ]
do
    sleep 1
    echo "waiting gluu server start ..."
done
echo "gluu server setup started..."
ssh -o IdentityFile=/etc/gluu/keys/gluu-console -o Port=60022 -o StrictHostKeyChecking=no \
-o UserKnownHostsFile=/dev/null -o PubKeyAuthentication=yes root@localhost \
"cd /install/community-edition-setup && ./setup.py -s -e -n -f setup.properties"