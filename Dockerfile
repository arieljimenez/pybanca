FROM frolvlad/alpine-glibc

# ENV VARS
ENV APPDIR=/app

# DIRS
RUN mkdir -p $APPDIR \
    /run/nginx

# SYSTEM
RUN apk add --update --no-cache \
    ca-certificates \
    gcc \
    nodejs-npm \
    mysql \
    mysql-client \
    python2 \
    python3 \
    build-base \
    py-sqlalchemy \
    nginx


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

WORKDIR $APPDIR

EXPOSE 80 8000 8080 8306

CMD "/bin/sh" $APPDIR"/scripts/start.sh"
