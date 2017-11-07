# Use phusion/baseimage as base image. To make your builds
# reproducible, make sure you lock down to a specific version, not
# to `latest`! See
# https://github.com/phusion/baseimage-docker/blob/master/Changelog.md
# for a list of version numbers.
FROM phusion/baseimage:0.9.15

MAINTAINER m.maatkamp@gmail.com version: 0.3

RUN apt-get -y update && apt-get dist-upgrade -yf && apt-get -y clean && apt-get -y autoremove
RUN apt-get install -y git subversion axel wget zip unzip cmake build-essential pulseaudio

# --- 
# GNURadio 

RUN mkdir /gnuradio
WORKDIR /gnuradio

RUN axel http://www.sbrac.org/files/build-gnuradio && chmod a+x ./build-gnuradio && printf "y\ny\ny\ny\n" | ./build-gnuradio -ja
RUN echo "export PYTHONPATH=/usr/local/lib/python2.7/dist-packages" > ~/.bashrc

# to install gr-ieee802-11 dependencies
RUN apt-get -y install swig liblog4cpp5-dev

# gr-foo
RUN cd /gnuradio && \
    git clone https://github.com/bastibl/gr-foo.git && \
    cd gr-foo && \
    git checkout 2ba97c8d6d1e6bb322446773e42cbdac347c0085 && \
    mkdir build && \
    cd build && \
    cmake .. && \
    make && \
    make install && \
    ldconfig

# Installation of gr-ieee802-11
RUN cd /gnuradio && \
    git https://github.com/h3dema/gr-ieee802-11.git && \
    cd gr-ieee802-11 && \
    mkdir build && \
    cd build && \
    cmake ..
#    && \
#    make && \
#    make install && \
#    ldconfig

ENTRYPOINT      ["/bin/bash"]
