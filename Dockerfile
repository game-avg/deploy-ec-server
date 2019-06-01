FROM alpine
RUN  apk --update add aria2 tzdata p7zip
ADD . /app
VOLUME ["/work"]
WORKDIR /app
ENTRYPOINT sh /app/entrypoint.sh