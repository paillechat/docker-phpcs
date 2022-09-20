ARG PHP
FROM php:${PHP} as production
LABEL \
	maintainer="paillechat <paillechat@gmail.com>" \
	repo="https://github.com/paillechat/docker-phpcs"

COPY --from=composer:2.0 /usr/bin/composer /usr/bin/composer
ENV PATH="${PATH}:/root/.composer/vendor/bin"

ARG PHPCS=@stable
RUN composer global require squizlabs/php_codesniffer:${PHPCS}

WORKDIR /app

ENTRYPOINT ["phpcs"]
CMD ["--version"]
