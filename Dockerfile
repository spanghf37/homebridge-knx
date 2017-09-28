FROM hypriot/rpi-node:slim

COPY tmp/qemu-arm-static /usr/bin/qemu-arm-static

RUN apt-get update

RUN apt-get install -y curl wget libavahi-compat-libdnssd-dev dbus avahi-daemon node-gyp make g++ build-essential avahi-discover libnss-mdns

RUN sed -i.bak 's/^#enable-dbus/enable-dbus/' /etc/avahi/avahi-daemon.conf

USER node

RUN npm install -g homebridge

# Run container
EXPOSE 5353 51826

CMD set -xe \
    && rm -f /var/run/dbus.pid \
    && dbus-daemon --system \
    && rm -f /var/run/avahi-daemon/pid \
    && avahi-daemon -D \
    && homebridge
