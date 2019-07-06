wget 'https://raw.githubusercontent.com/user1121114685/koolproxyR/master/koolproxyR/koolproxyR/data/rules/kp.dat' -O files/usr/share/koolproxy/data/rules/kp.dat
wget -O daily.txt https://raw.githubusercontent.com/user1121114685/koolproxyR/master/koolproxyR/koolproxyR/data/rules/easylistchina.txt
wget -O koolproxy.txt https://raw.githubusercontent.com/user1121114685/koolproxyR/master/koolproxyR/koolproxyR/data/rules/fanboy-annoyance.txt
wget -O kp.dat https://raw.githubusercontent.com/user1121114685/koolproxyR/master/koolproxyR/koolproxyR/data/rules/kp.dat
wget -O user.txt https://raw.githubusercontent.com/user1121114685/koolproxyR/master/koolproxyR/koolproxyR/data/rules/user.txt
wget -O koolproxy_tmp.txt https://raw.githubusercontent.com/user1121114685/koolproxyR/master/koolproxyR/koolproxyR/data/rules/kpr_video_list.txt
wget -O daily_tmp.txt https://raw.githubusercontent.com/user1121114685/koolproxyR/master/koolproxyR/koolproxyR/data/rules/yhosts.txt
wget -O daily_tmp.txt https://raw.githubusercontent.com/user1121114685/koolproxyR/master/koolproxyR/koolproxyR/data/rules/yhosts.txt
cat koolproxy_tmp.txt >>koolproxy.txt
cat daily_tmp.txt >>daily.txt
rm -rf koolproxy_tmp.txt
rm -rf daily_tmp.txt
#wget 'https://koolproxy.com/downloads/arm' -O files/bin/arm
#wget 'https://koolproxy.com/downloads/i386' -O files/bin/i386
#wget 'https://koolproxy.com/downloads/mips' -O files/bin/mips
#wget 'https://koolproxy.com/downloads/mipsel' -O files/bin/mipsel
#wget 'https://koolproxy.com/downloads/x86_64' -O files/bin/x86_64
#chmod +x files/bin/*

wget https://easylist-downloads.adblockplus.org/easylistchina+easylist.txt -O- | grep ^\|\|[^\*]*\^$ | sed -e 's:||:address\=\/:' -e 's:\^:/0\.0\.0\.0:' > files/usr/share/koolproxy/dnsmasq.adblock
sed -i '/youku/d' files/usr/share/koolproxy/dnsmasq.adblock
sed -i '/[1-9]\{1,3\}\.[1-9]\{1,3\}\.[1-9]\{1,3\}\.[1-9]\{1,3\}/d' files/usr/share/koolproxy/dnsmasq.adblock
