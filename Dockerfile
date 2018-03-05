
FROM frolvlad/alpine-glibc

# DIRS
RUN mkdir -p /app

# ENV VARS
ENV PYTHONUNBUFFERED=1

# SYSTEM
RUN apk add --update --no-cache ca-certificates \
                                gcc \
                                nodejs-npm \
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
RUN npm install -g elm --unsafe-perm=true --allow-root

WORKDIR /app

EXPOSE 80 8000

CMD ["/bin/sh"]
# CMD sh /app/scripts/start.sh