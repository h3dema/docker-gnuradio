This is a Dockerfile for building GNURadio 3.7.1 and its modules:

- uhd (003.008.000-release)
- rtl-sdr
- hackrf
- gr-iqba
- bladeRF
- gr-osmosdr
- gr-baz
- gr-extras

## BUILD

To build an image with this file simply use:

```
$ docker build -t marcelmaatkamp/gnuradio github.com/h3dema/docker-gnuradio
```

## RUN

To run with a local USRP
```
$ docker run -t -i --privileged -v /dev/bus/usb:/dev/bus/usb marcelmaatkamp/gnuradio /bin/bash
```

## Examples

Run rtl_tcp over your network:
```
$ docker run -ti \
  --privileged \
  --entrypoint=rtl_tcp \
  -p 1234:1234 \
  marcelmaatkamp/gnuradio:3.7.1 -a 0.0.0.0
```
