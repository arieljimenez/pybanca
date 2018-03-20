FROM frolvlad/alpine-glibc

# ENV VARS
ENV APPDIR=/app
ENV REDIS_VERSION 4.0.8
ENV REDIS_DOWNLOAD_URL http://download.redis.io/releases/redis-4.0.8.tar.gz
ENV REDIS_DOWNLOAD_SHA ff0c38b8c156319249fec61e5018cf5b5fe63a65b61690bec798f4c998c232ad

# DIRS
RUN mkdir -p $APPDIR \
    /run/nginx

# SYSTEM
RUN apk add --update --no-cache \
    build-base \
    ca-certificates \
    gcc \
    mysql \
    mysql-client \
    nginx \
    nodejs-npm \
    py-sqlalchemy \
    python2 \
    python3


# Build japronto
RUN apk add --no-cache --virtual .build-deps py3-pip build-base python3-dev && \
    pip3 --no-cache install https://github.com/squeaky-pl/japronto/archive/master.zip && \
    apk del .build-deps && \
    rm -rf /var/cache/apk/*

# PYTHON
RUN pip3 install --upgrade pip setuptools && \
    pip3 install japronto

# JS
RUN npm install -g elm --unsafe-perm=true

# REDIS
RUN addgroup -S redis && adduser -S -G redis redis
RUN apk add --no-cache 'su-exec>=0.2'

RUN set -ex; \
    apk add --no-cache --virtual .build-deps \
    coreutils \
    gcc \
    linux-headers \
    make \
    musl-dev

RUN wget -O redis.tar.gz "$REDIS_DOWNLOAD_URL"; \
    echo "$REDIS_DOWNLOAD_SHA *redis.tar.gz" | sha256sum -c -; \
    mkdir -p /usr/src/redis; \
    tar -xzf redis.tar.gz -C /usr/src/redis --strip-components=1; \
    rm redis.tar.gz;

RUN grep -q '^#define CONFIG_DEFAULT_PROTECTED_MODE 1$' /usr/src/redis/src/server.h; \
    sed -ri 's!^(#define CONFIG_DEFAULT_PROTECTED_MODE) 1$!\1 0!' /usr/src/redis/src/server.h; \
    grep -q '^#define CONFIG_DEFAULT_PROTECTED_MODE 0$' /usr/src/redis/src/server.h;

# COMPILE IT
RUN make -C /usr/src/redis -j "$(nproc)"; \
    make -C /usr/src/redis install; \
    \
    rm -r /usr/src/redis; \
    \
    runDeps="$( \
    scanelf --needed --nobanner --format '%n#p' --recursive /usr/local \
    | tr ',' '\n' \
    | sort -u \
    | awk 'system("[ -e /usr/local/lib/" $1 " ]") == 0 { next } { print "so:" $1 }' \
    )"; \
    apk add --virtual .redis-rundeps $runDeps; \
    apk del .build-deps; \
    \
    redis-server --version

RUN mkdir /data && chown redis:redis /data

VOLUME /data

WORKDIR $APPDIR

EXPOSE 80 8000 8080 8306

CMD "/bin/sh" $APPDIR"/scripts/start.sh"
