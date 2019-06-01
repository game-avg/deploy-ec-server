FROM alpine
RUN  sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories && \
     apk --update add aria2 tzdata p7zip
ADD . /app
RUN chmod +x /app/entrypoint.sh
VOLUME ["/work"]
WORKDIR /app
ENTRYPOINT sh /app/entrypoint.sh