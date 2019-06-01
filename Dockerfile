FROM alpine
RUN  apk --update add aria2 tzdata p7zip
ADD . /app
VOLUME ["/app/storage"]
WORKDIR /app
ENTRYPOINT ./entrypoint.sh