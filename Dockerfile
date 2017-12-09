FROM arm32v7/node

COPY tmp/qemu-arm-static /usr/bin/qemu-arm-static

RUN apt-get update \
    && apt-get upgrade -y

RUN apt-get install -y sudo curl wget libavahi-compat-libdnssd-dev dbus avahi-daemon make g++ build-essential avahi-discover libnss-mdns

RUN sed -i.bak 's/^#enable-dbus/enable-dbus/' /etc/avahi/avahi-daemon.conf

RUN git clone git://git.drogon.net/wiringPi && cd wiringPi && git pull origin && ./build

RUN wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.33.6/install.sh | bash

RUN export NVM_DIR="$HOME/.nvm" && [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

RUN command -v nvm && nvm install 8.9.2 && nvm use 8.9.2

RUN npm install -g wiringpi-node --unsafe-perm

RUN npm install -g homebridge --unsafe-perm

RUN npm install -g homebridge-rpi-chacon --unsafe-perm

EXPOSE 5353 51826

RUN mkdir -p /var/run/dbus
 
CMD set -xe \
     && rm -f /var/run/dbus/pid \
     && dbus-daemon --system \
     && rm -f /var/run/avahi-daemon/pid \
     && avahi-daemon -D \
     && homebridge
