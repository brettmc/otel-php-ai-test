FROM php:8.1

RUN addgroup -gid "1000" --system php \
  && adduser --system --gecos "" --ingroup "php" --uid "1000" php

ADD https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/
RUN chmod +x /usr/local/bin/install-php-extensions \
  && install-php-extensions \
    @composer \
    apcu \
    sockets \
    zip

RUN install-php-extensions \
    ast \
    open-telemetry/opentelemetry-php-instrumentation@main \
    xdebug-stable

RUN mkdir -p /srv/app \
  && chown php /srv/app
WORKDIR /srv/app

USER php
