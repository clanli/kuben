echo '1' > /proc/sys/net/bridge/bridge-nf-call-iptables
echo "net.bridge.bridge-nf-call-iptables = 1" >> /etc/sysctl.d/99-sysctl.conf
sysctl -p /etc/sysctl.conf
