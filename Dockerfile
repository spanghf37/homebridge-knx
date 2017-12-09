FROM arm32v7/node:8.9.3

COPY tmp/qemu-arm-static /usr/bin/qemu-arm-static

RUN apt-get update \
    && apt-get upgrade

RUN apt-get install -y curl sudo wget libavahi-compat-libdnssd-dev dbus avahi-daemon make g++ build-essential avahi-discover libnss-mdns

RUN sed -i.bak 's/^#enable-dbus/enable-dbus/' /etc/avahi/avahi-daemon.conf

RUN npm install -g homebridge --unsafe-perm

RUN npm install -g homebridge-knx --unsafe-perm

RUN sudo npm install -g wiringpi-node --unsafe-perm

RUN sudo npm install -g homebridge-rpi-chacon --unsafe-perm

EXPOSE 5353 51826

RUN mkdir -p /var/run/dbus
 
CMD set -xe \
     && rm -f /var/run/dbus/pid \
     && dbus-daemon --system \
     && rm -f /var/run/avahi-daemon/pid \
     && avahi-daemon -D \
     && homebridge
