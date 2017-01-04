FROM alpine:edge

ENV GOPATH /go
RUN apk add --no-cache build-base git go \
    && mkdir /go \
    && go get github.com/maklesoft/padlock-cloud \
    && mkdir -p /padlock-cloud \
    && mv /go/bin/padlock-cloud /padlock-cloud/padlock-cloud \
    && mv /go/src/github.com/maklesoft/padlock-cloud/assets /padlock-cloud/assets \
    && rm -rf /go \
    && adduser -S padlock \
    && chown -R padlock /padlock-cloud \
    && apk del --no-cache build-base git go

USER padlock
WORKDIR /padlock-cloud

ENTRYPOINT [ "/padlock-cloud/padlock-cloud" ]
CMD [ "help" ]
