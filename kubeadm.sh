cat <<EOF > kube_adm.yml
apiVersion: kubeadm.k8s.io/v1alpha1
kind: MasterConfiguration
etcd:
  endpoints:
  - "http://192.168.10.20:2379"
  - "http://192.168.10.21:2379"
  - "http://192.168.10.22:2379"
apiServerCertSANs:
- "192.168.10.20"
- "192.168.10.21"
- "192.168.10.22"
- "192.168.10.19"
- "127.0.0.1"
- "master.ekvagen.com"
token: "9aeb42.99b7540a5833866a"
tokenTTL: "0s"
api:
  advertiseAddress: "192.168.10.19"
networking:
  podSubnet: 10.244.0.0/16
EOF
