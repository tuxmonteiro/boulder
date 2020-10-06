FROM golang:latest

MAINTAINER Marcelo Teixeira Monteiro <marcelotmonteiro@gmail.com>

EXPOSE 4000 4002 4003 8053 8055

ENV PATH /usr/local/go/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin/
ENV GOPATH /go
ENV GO15VENDOREXPERIMENT=1

RUN apt update -y; apt install rsyslog -y

RUN go get github.com/letsencrypt/boulder || true; \
    cd /go/src/github.com/letsencrypt/boulder; \
    make || true

WORKDIR /go/src/github.com/letsencrypt/boulder

RUN adduser --disabled-password --gecos "" --home /go/src/github.com/letsencrypt/boulder -q buser
RUN chown -R buser /go/

ENTRYPOINT /go/src/github.com/letsencrypt/boulder/test/entrypoint.sh
