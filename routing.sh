#!/bin/bash
case "$1" in
  start)
    iptables -t nat -D POSTROUTING --out-interface eth0 -j MASQUERADE 2>/dev/null
    iptables -D FORWARD --in-interface eth1 -j ACCEPT 2>/dev/null
    iptables -t nat -A POSTROUTING --out-interface eth0 -j MASQUERADE
    iptables -A FORWARD --in-interface eth1 -j ACCEPT
    echo 1 > /proc/sys/net/ipv4/ip_forward
    ;;
  stop)
    iptables -t nat -D POSTROUTING --out-interface enp0s3 -j MASQUERADE
    iptables -D FORWARD --in-interface enp0s8 -j ACCEPT
    echo 0 > /proc/sys/net/ipv4/ip_forward
    ;;
  *)
    echo "Usage: /etc/init.d/routing.sh {start|stop}"
    exit 1
    ;;
esac
exit 0
