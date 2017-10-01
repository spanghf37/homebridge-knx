rm -f /var/run/dbus/pid /var/run/avahi-daemon/pid
dbus-daemon --system
avahi-daemon -D
service dbus start
service avahi-daemon start
homebridge
