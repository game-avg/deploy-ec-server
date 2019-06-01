FROM alpine
RUN  apk --update add aria2 tzdata p7zip
ADD . /app
VOLUME ["/app"]
WORKDIR /app
ENTRYPOINT sh entrypoint.sh