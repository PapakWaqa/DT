#!/bin/bash

source $DT_HOME/conf/DT.conf
envsubst < $DT_HOME/web/config/environment.tpl >$DT_HOME/web/config/environment
while read -r line ; do eval echo $line; done <$DT_HOME/conf/DT.conf|cut -d ' ' -f2|tail -n +6 >>$DT_HOME/web/config/environment

[ "$?" == "0" ] && echo -e "\033[44;37mCreated SSH_ENVIRMOMENT FILE ...OK\033[0m"
#"\033[43;37mCreated SSH_ENVIRMOMENT FILE"...ok \033[0m"
