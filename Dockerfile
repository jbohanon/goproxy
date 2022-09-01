FROM golang:alpine AS build

COPY . /usr/local/src/goproxy

RUN apk add --no-cache git
RUN cd /usr/local/src/goproxy && go mod download && CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -trimpath -ldflags "-s -w" -o /usr/local/bin/ ./cmd/goproxy

RUN mkdir /data

EXPOSE 8080

ENTRYPOINT ["/usr/local/bin/goproxy"]
