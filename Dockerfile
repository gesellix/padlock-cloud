FROM alpine:edge

ENV GOPATH /go

ENV PC_ASSETS_PATH /padlock-assets
ENV PC_CORS true

RUN apk add --no-cache build-base git go \
    && mkdir /go \
    && go get github.com/maklesoft/padlock-cloud \
    && mkdir -p /padlock-cloud \
    && mv /go/bin/padlock-cloud /padlock-cloud/padlock-cloud \
    && mv /go/src/github.com/maklesoft/padlock-cloud/assets /padlock-assets \
    && rm -rf /go \
    && adduser -S padlock \
    && chown -R padlock /padlock-cloud \
    && apk del --no-cache build-base git go

USER padlock
WORKDIR /padlock-cloud
EXPOSE 3000

ENTRYPOINT [ "./padlock-cloud" ]
CMD [ "help" ]
