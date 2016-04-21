sudo ifconfig wlan0 down
sudo brctl delbr br0
sudo ifconfig eth0 0.0.0.0 promisc
sudo brctl addbr br0
sudo brctl addif br0 eth0
sudo ./hostapd hostapd.conf -B
sudo brctl show
sudo ifconfig br0 up
sudo dhclient br0
