FROM amd64/node:latest

RUN apt-get update

RUN apt-get install -y curl wget libavahi-compat-libdnssd-dev dbus avahi-daemon make g++ build-essential avahi-discover libnss-mdns

RUN sed -i.bak 's/^#enable-dbus/enable-dbus/' /etc/avahi/avahi-daemon.conf

RUN npm install -g homebridge --unsafe-perm

RUN npm install -g homebridge-knx --unsafe-perm

# Run container
EXPOSE 5353 51826

# USER root

RUN mkdir -p /var/run/dbus

# ADD run.sh /root/run.sh

# RUN chmod +x /root/run.sh

# CMD ["/root/run.sh"]
 
 CMD set -xe \
     && rm -f /var/run/dbus/pid \
     && dbus-daemon --system \
     && rm -f /var/run/avahi-daemon/pid \
     && avahi-daemon -D \
     && homebridge
