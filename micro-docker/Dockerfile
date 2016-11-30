FROM debian:wheezy

RUN apt-get update && apt-get install -y \
               ipmitool \
               curl \
               vim-tiny \
               less \
               ca-certificates \
               sudo \
               dmidecode \
               lshw \
               lsscsi \
               pciutils \
               ethtool \
               smartmontools \
               ohai \
               lldpd \
               hdparm \
    && rm -rf /var/lib/apt/lists/*

ENV NODE_VERSION 4.6.2
RUN curl -SLO "http://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-x64.tar.gz" \
    && tar -xzf "node-v$NODE_VERSION-linux-x64.tar.gz" -C /usr/local --strip-components=1 \
    && rm "node-v$NODE_VERSION-linux-x64.tar.gz"
ADD entry.bash /usr/local/bin/
CMD /usr/local/bin/entry.bash
