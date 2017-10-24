![Build Status](https://travis-ci.org/spanghf37/homebridge-knx.svg?branch=master)

# homebridge-knx
homebridge-knx docker container for amd64bits

# 1. Configuration files

Copy and edit ```config.json``` and ```knx_config.json``` to ```/home/docker/homebridge``` on Docker host.

# 2. docker run command

```
docker run --restart=always --net=host -v /home/docker/homebridge/:/root/.homebridge/ spanghf37/homebridge-knx:amd64
```

# 3. Edit iptables (firewall) rules
On Photon OS (VMWare), edit script ```iptables``` under ```/etc/systemd/scripts``` and add the following at the end of file:

```
#Homebridge-KNX rules
iptables -A INPUT -p tcp --dport 5353 -j ACCEPT
iptables -A INPUT -p udp --dport 5353 -j ACCEPT
iptables -A INPUT -p tcp --dport 51826 -j ACCEPT
iptables -A INPUT -p udp --dport 51826 -j ACCEPT
iptables -A INPUT -p tcp --dport 18081 -j ACCEPT

#knxd rules (assuming server listening on 6720 and 3671)
iptables -A INPUT -p tcp --dport 3671 -j ACCEPT
iptables -A INPUT -p udp --dport 3671 -j ACCEPT
iptables -A INPUT -p tcp --dport 6720 -j ACCEPT
```
