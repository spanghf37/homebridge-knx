FROM arm32v6/alpine:latest

COPY tmp/qemu-arm-static /usr/bin/qemu-arm-static

RUN set -xe \
    && apk update \
    && apk add avahi \
               avahi-compat-libdns_sd \
               avahi-dev \
               build-base \
               dbus \
               nodejs \
               nodejs-npm \
               python \
    && npm install -g homebridge \
    && npm install -g homebridge-knx \
    && apk del avahi-dev \
               build-base \
               python \
    && rm -rf /var/cache/apk/*

# Run container
EXPOSE 5353 51826

CMD set -xe \
    && rm -f /var/run/dbus.pid \
    && dbus-daemon --system \
    && rm -f /var/run/avahi-daemon/pid \
    && avahi-daemon -D \
    && homebridge
