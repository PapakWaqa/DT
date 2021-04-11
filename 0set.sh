#!/bin/bash
cat ~/.bash_profile 2>/dev/null|grep "DT_HOME" >/dev/null
[ "$?" == "0" ] && echo "You have been added EVN args. before" && exit 1

sudo echo -e "export DT_HOME=~/DT\n"'export PATH=$DT_HOME/bin:$PATH'>> ~/.bash_profile && echo "it will reboot after 5 seconds" && sleep 5 && sudo reboot
