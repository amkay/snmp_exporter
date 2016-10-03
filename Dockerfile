# Start from an Alpine image with the latest version of Go installed
# and a workspace (GOPATH) configured at /go.
FROM golang:alpine
MAINTAINER  Max Käufer <am-kay@web.de>

# Build the outyet command inside the container.
# (You may fetch or manage dependencies here,
# either manually or with a tool like "godep".)
RUN apk add --update \
      git \
 && rm -rf /var/cache/apk/*

# Copy the local package files to the container's workspace.
ADD . /go/src/github.com/amkay/snmp_exporter

RUN go install github.com/amkay/snmp_exporter

COPY snmp.yml       /etc/snmp_exporter/snmp.yml

EXPOSE      9116
ENTRYPOINT  [ "/go/bin/snmp_exporter" ]
CMD         [ "-config.file=/etc/snmp_exporter/snmp.yml" ]
