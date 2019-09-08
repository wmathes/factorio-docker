FROM alpine

LABEL maintainer="https://github.com/factoriotools/factorio-docker"

ENV RCLONE_VERSION=v1.49.1

# install rclone
RUN apk add --no-cache \
    ca-certificates \
    wget \
  && cd /tmp \
  && wget -qO ./rclone.zip http://downloads.rclone.org/${RCLONE_VERSION}/rclone-${RCLONE_VERSION}-linux-amd64.zip \
  && unzip ./rclone.zip \
  && mv ./rclone-*/rclone /usr/bin \
  && (rm -rf "/tmp/"* 2>/dev/null || true)

VOLUME /factorio

EXPOSE $PORT/udp $RCON_PORT/tcp

COPY files/ /

ENTRYPOINT ["/docker-entrypoint.sh"]
