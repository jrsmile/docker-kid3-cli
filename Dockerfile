FROM ubuntu
ARG S6_OVERLAY_VERSION=3.1.5.0
ARG DEBCONF_NOWARNINGS="yes"

RUN DEBIAN_FRONTEND=noninteractive apt-get -qq update -y && DEBIAN_FRONTEND=noninteractive apt-get -oDpkg::Use-Pty=false -o DPkg::options::="--force-confdef" -qq install software-properties-common -y && add-apt-repository ppa:ufleisch/kid3
RUN DEBIAN_FRONTEND=noninteractive apt-get -qq update -y && DEBIAN_FRONTEND=noninteractive apt-get -oDpkg::Use-Pty=false -o DPkg::options::="--force-confdef" --no-install-recommends -qq install apt-utils -y && DEBIAN_FRONTEND=noninteractive apt-get -oDpkg::Use-Pty=false -o DPkg::options::="--force-confdef" -qq upgrade -y && DEBIAN_FRONTEND=noninteractive apt-get -oDpkg::Use-Pty=false -o DPkg::options::="--force-confdef" -qq install tar xz-utils kid3-cli -y
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ADD https://github.com/just-containers/s6-overlay/releases/download/v${S6_OVERLAY_VERSION}/s6-overlay-noarch.tar.xz /tmp
RUN tar -C / -Jxpf /tmp/s6-overlay-noarch.tar.xz
ADD https://github.com/just-containers/s6-overlay/releases/download/v${S6_OVERLAY_VERSION}/s6-overlay-x86_64.tar.xz /tmp
RUN tar -C / -Jxpf /tmp/s6-overlay-x86_64.tar.xz

CMD ["/bin/bash"]
ENTRYPOINT ["/init"]