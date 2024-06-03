FROM ubuntu:jammy

COPY . /app/code

WORKDIR /app/code

ENV DEBIAN_FRONTEND noninteractive

RUN apt update && \
    apt -y install python3 build-essential snmp libsnmp-dev autoconf libtool libusb-dev libusb-1.0-0-dev && \
    apt clean

RUN ./autogen.sh

RUN mkdir -p /var/state/ups && \
    chmod 0770 /var/state/ups

RUN ./configure --with-user=root --with-group=root --with-snmp --with-usb --prefix=/app/config

RUN make && make install && make clean

WORKDIR /app/config

    
