![Build Status](https://travis-ci.org/spanghf37/homebridge-knx.svg?branch=master)

# homebridge-knx
homebridge-knx docker container for raspberry-pi 64bits

# 1. Configuration files

Copy and edit ```config.json``` and ```knx_config.json``` to ```/home/docker/homebridge``` on the Raspberry Pi.

# 2. docker run command

```
docker run -p 5353:5353 -p 51826:51826 --net=host -v /home/docker/homebridge/:/root/.homebridge/ spanghf37/homebridge-knx:latest
```
