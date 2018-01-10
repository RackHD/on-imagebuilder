FROM debian:jessie

RUN apt-get update && apt-get install --no-install-recommends -y \
               ipmitool \
               python \
               curl \
               vim-tiny \
               less \
               ca-certificates \
               sudo \
               ifupdown \
               dmidecode \
               lshw \
               lsscsi \
               pciutils \
               ethtool \
               smartmontools \
               ohai \
               lldpd \
               initramfs-tools \
               apt-utils \
               hdparm \
               udev \
    && rm -rf /var/lib/apt/lists/*

ENV NODE_VERSION 4.6.2
RUN curl -SLO "http://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-x64.tar.gz" \
    && tar -xzf "node-v$NODE_VERSION-linux-x64.tar.gz" -C /usr/local --strip-components=1 \
    && rm "node-v$NODE_VERSION-linux-x64.tar.gz"

ARG PERCCLI=perccli_1.11.03-1_all.deb
ADD $PERCCLI .
RUN dpkg -i $PERCCLI \
    && rm $PERCCLI

ADD entry.bash /usr/local/bin/
CMD /usr/local/bin/entry.bash
