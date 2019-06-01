FROM alpine
RUN  apk --update add aria2 tzdata p7zip
ADD . /app
RUN chmod +x /app/entrypoint.sh
VOLUME ["/app/storage"]
WORKDIR /app
ENTRYPOINT ./entrypoint.sh