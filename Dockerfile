FROM alpine
RUN  apk --update add aria2 tzdata p7zip
ADD . /APP
VOLUME ["/app/storage"]
WORKDIR /app
RUN go build -v -o /go/src/app/app cmd/main.go