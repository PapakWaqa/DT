#!/bin/bash

sudo apk update && sudo  apk upgrade && sudo apk add sudo nano bash procps python3 sshpass git openjdk8 && sudo rm -rf /var/cache/apk/*

echo "Copied hosts file to /etc/hosts"
sudo cp web/config/hosts /etc/hosts


echo "Copied busybox_httpd to /bin"
sudo cp ~/DT/web/pkg/busybox_httpd /bin/busybox_httpd


cat ~/.bash_profile 2>/dev/null|grep "DT_HOME" >/dev/null
[ "$?" == "0" ] && echo "You have been added EVN args before this time" && exit 1


sudo echo -e "export DT_HOME=~/DT\n"'export PATH=$DT_HOME/bin:$PATH'>> ~/.bash_profile && echo "it will reboot after 5 seconds" && sleep 5 && sudo reboot
