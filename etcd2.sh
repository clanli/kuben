yum -y install etcd

cat <<EOF > /etc/etcd/etcd.conf
# [member]
ETCD_NAME=etcd2
ETCD_DATA_DIR="/var/lib/etcd/default.etcd"
ETCD_LISTEN_PEER_URLS="http://192.168.10.21:2380"
ETCD_LISTEN_CLIENT_URLS="http://192.168.10.21:2379,http://127.0.0.1:2379"
# [cluster]
ETCD_INITIAL_ADVERTISE_PEER_URLS="http://192.168.10.21:2380"
ETCD_INITIAL_CLUSTER="etcd1=http://192.168.10.20:2380,etcd2=http://192.168.10.21:2380,etcd3=http://192.168.10.22:2380"
ETCD_INITIAL_CLUSTER_STATE="new"
ETCD_INITIAL_CLUSTER_TOKEN="KUBE-ETCD-CLUSTER"
ETCD_ADVERTISE_CLIENT_URLS="http://192.168.10.21:2379"
EOF

systemctl enable etcd
systemctl start etcd
