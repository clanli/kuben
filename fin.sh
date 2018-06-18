echo "-- Setting hostname --"
echo "What should be the hostname?"
echo -n ":"
read NAME
if [[ $NAME ]]; then 
	sudo hostnamectl set-hostname $NAME
fi

echo "-- Setting IP --"
echo "What IP?"
echo -n "192.168.10."
read IPADDR
if [[ $IPADDR ]]; then
	nmcli con mod eth0 ipv4.addresses 192.168.10.$IPADDR/24
	nmcli con mod eth0 ipv4.gateway 192.168.10.1
	nmcli con mod eth0 ipv4.dns "192.168.10.1"
	nmcli con mod eth0 ipv4.method manual
	nmcli con mod eth0 connection.autoconnect yes
fi
systemctl restart network

echo "-- Installing additional software"
sleep 1
yum install mlocate tcpdump -y
yum update -y
updatedb

# Firewall
echo "-- Disable firewall --"
sleep 1
systemctl stop firewalld
systemctl disable firewalld

# SELinux
echo "-- Disable SELinux --"
sleep 1
perl -pi -e 's/^SELINUX=enforcing/SELINUX=disabled/' /etc/selinux/config
setenforce 0

