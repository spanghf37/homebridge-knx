FROM arm64v8/node:latest

COPY tmp/qemu-aarch64-static /usr/bin/qemu-aarch64-static

RUN apt-get update

RUN apt-get install -y curl wget libavahi-compat-libdnssd-dev dbus avahi-daemon make g++ build-essential avahi-discover libnss-mdns

RUN sed -i.bak 's/^#enable-dbus/enable-dbus/' /etc/avahi/avahi-daemon.conf

RUN npm install -g homebridge --unsafe-perm

RUN npm install -g homebridge-knx --unsafe-perm

# Run container
EXPOSE 5353 51826

USER root

RUN mkdir -p /var/run/dbus

ADD run.sh /root/run.sh

RUN chmod +x /root/run.sh

CMD ["/root/run.sh"]
