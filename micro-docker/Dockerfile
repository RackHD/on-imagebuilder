FROM gliderlabs/alpine
# Install any dependencies needed
RUN apk update && \
    apk add bash sed dmidecode ruby ruby-irb open-lldp util-linux open-vm-tools sudo smartmontools && \
    apk add lshw ipmitool nodejs curl pciutils lsscsi --update-cache --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ --allow-untrusted && \
    echo "install: --no-rdoc --no-ri" > /etc/gemrc && \
    gem install json_pure daemons && \
    apk add --virtual build_deps build-base ruby-dev libc-dev libffi-dev && gem install ohai && apk del build_deps 
ADD entry.bash /usr/local/bin/
CMD /usr/local/bin/entry.bash
