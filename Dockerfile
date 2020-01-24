FROM golang:1.13 AS build-env

ADD . /src
ENV CGO_ENABLED 0
RUN cd /src && go build -mod=vendor -o service

FROM alpine
WORKDIR /app
COPY --from=build-env /src/service /usr/local/bin/service
ENTRYPOINT /usr/local/bin/service
