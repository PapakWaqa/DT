#!/bin/bash

hstname="`hostname`" && [ ! $hstname == "gw" ] && echo "must run on gw" && exit 1
echo $hstname
which ssh > /dev/null 2>&1
[ ! "$?" == "0" ] && sudo apk add openssh >/dev/null && echo -e "installed openssh\n"
[ ! -f ~/.ssh/id_rsa.pub ] && ssh-keygen -q -f $HOME/.ssh/id_rsa -t rsa -P '' 
for i in wka01 wka02 wka03 mas01 ds01
do
    ssh-keyscan -t rsa  $i >> ~/.ssh/known_hosts 2>/dev/null
    sshpass -P $USER ssh-copy-id bigred@$i
done    
