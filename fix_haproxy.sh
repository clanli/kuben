cat << EOF > /etc/haproxy/haproxy.cfg
global
   log /dev/log local0
   log /dev/log local1 notice
   chroot /var/lib/haproxy
   stats timeout 30s
   user haproxy
   group haproxy
   daemon

defaults
    mode                    tcp
    log                     global
    option                  httplog
    option                  dontlognull
    option                  http-server-close
    option                  redispatch
    retries                 3
    timeout http-request    10s
    timeout queue           1m
    timeout connect         10s
    timeout client          1m
    timeout server          1m
    timeout http-keep-alive 10s
    timeout check           10s
    maxconn                 3000

frontend http_stats
   bind *:8080
   mode http
   stats uri /haproxy?stats

frontend haproxy_kube
    bind *:6443
    mode tcp
    option tcplog
    timeout client  10800s
    default_backend masters

backend masters
    mode tcp
    option tcplog
    balance leastconn
    timeout server  10800s
    server master1 192.168.10.20:6443
    server master2 192.168.10.21:6443
    server master2 192.168.10.22:6443
EOF
