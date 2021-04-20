#/etc/mactohost
wget -qO - "$WEB_URL/config/mactohost" | sudo tee /etc/mactohost &>/dev/null
[ "$?" == "0" ] && echo "mactohost copied"
