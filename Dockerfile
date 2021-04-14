FROM tindy2013/subconverter
MAINTAINER Stille <stille@ioiox.com>

ENV VERSION v0.6.4

WORKDIR /base
RUN apk add tzdata && \
    cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    echo "Asia/Shanghai" > /etc/timezone && \
    apk del tzdata

COPY groups.txt rulesets.txt /base/snippets/

EXPOSE 25500

WORKDIR /base

CMD subconverter
