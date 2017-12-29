# Debian:wheezy is chosen to install lib32bz2-1.0
FROM debian:wheezy

RUN apt-get update && apt-get install --no-install-recommends -y \
               ipmitool \
               python \
               curl \
               vim-tiny \
               less \
               ca-certificates \
               sudo \
               ifupdown \
               lib32z1 \
               lib32ncurses5 \
               lib32bz2-1.0 \
               lib32gcc1 \
               lib32stdc++6 \
               unzip \
               udev \
    && rm -rf /var/lib/apt/lists/*

ARG NODE_VERSION=4.6.2
RUN curl -SLO "http://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-x64.tar.gz" \
    && tar -xzf "node-v$NODE_VERSION-linux-x64.tar.gz" -C /usr/local --strip-components=1 \
    && rm "node-v$NODE_VERSION-linux-x64.tar.gz"

RUN mkdir -p /opt/intel

ENV FLASHUPDT flashupdt
ADD $FLASHUPDT /opt/intel

ENV SYSCFG syscfg
ADD $SYSCFG /opt/intel

RUN chmod 755 /opt/intel/$FLASHUPDT \
    && chmod 755 /opt/intel/$SYSCFG

ADD entry.bash /usr/local/bin/
CMD /usr/local/bin/entry.bash
