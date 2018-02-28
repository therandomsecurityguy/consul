# Docker file to run Hashicorp Consul (https://www.consul.io)

FROM alpine:3.7
MAINTAINER Derek Chamorro <therandomsecurityguy@gmail.com>

ENV VERSION 1.0.6

ADD https://releases.hashicorp.com/consul/${VERSION}/consul_${VERSION}_linux_amd64.zip /tmp/
ADD https://releases.hashicorp.com/consul/${VERSION}/consul_${VERSION}_SHA256SUMS      /tmp/


WORKDIR /tmp

RUN apk --update add curl bash ca-certificates \
  && cat consul_${VERSION}_SHA256SUMS | grep linux_amd64 | sha256sum -c \
  && unzip consul_${VERSION}_linux_amd64.zip \
  && mv consul /bin/ \
  && rm -rf consul_${VERSION}_linux_amd64.zip \
  && rm -rf /tmp/* /var/cache/apk/*


# Listener API UDP ports
EXPOSE 8300 8301 8301/udp 8302 8302/udp 8400 8500 8600 8600/udp

VOLUME ["/data"]

ENTRYPOINT ["/bin/consul"]

CMD ["agent", "-data-dir", "/data"]
