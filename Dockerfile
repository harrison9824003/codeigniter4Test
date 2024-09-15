FROM php:8.2-apache

# 安装基本模块
RUN set -ex && \
    apt-get update && \
    apt-get install -y \
        procps \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng-dev \
        openssl \
        libssh-dev \
        libpcre3 \
        libpcre3-dev \
        libnghttp2-dev \
        libhiredis-dev \
        libicu-dev \
        curl \
        wget \
        zip \
        unzip \
        git \
        vim && \
    apt autoremove && apt clean

# 安装 PHP 扩展
RUN docker-php-ext-configure gd --with-freetype --with-jpeg
RUN docker-php-ext-install iconv
RUN docker-php-ext-install gd
RUN docker-php-ext-install pdo_mysql
RUN docker-php-ext-install mysqli
RUN docker-php-ext-install iconv
RUN docker-php-ext-install opcache
RUN docker-php-ext-install sockets
RUN docker-php-ext-install pcntl
RUN docker-php-ext-install intl

RUN echo "opcache.enable_cli=1" >> /usr/local/etc/php/conf.d/docker-php-ext-opcache.ini

# 安装 Redis 扩展
RUN pecl install redis && docker-php-ext-enable redis

# 安装 Composer
ENV COMPOSER_ALLOW_SUPERUSER 1
RUN curl -sS https://getcomposer.org/installer | php && \
    mv composer.phar /usr/local/bin/composer && \
    composer self-update --clean-backups

# 设置台北时区
RUN /bin/cp /usr/share/zoneinfo/Asia/Taipei /etc/localtime
RUN echo 'Asia/Taipei' > /etc/timezone 
RUN echo "[Date]\ndate.timezone=Asia/Taipei" > /usr/local/etc/php/conf.d/timezone.ini

# 启动脚本
COPY ./.dockerConfig/start.sh /start.sh
RUN chmod +x /start.sh

# 建立 /var/www/html
RUN mkdir -p /var/www/html

# 复制应用程序代码
COPY ./ /var/www/html

# 复制 Apache 配置文件
COPY ./.dockerConfig/000-default.conf /etc/apache2/sites-enabled/000-default.conf

# 设置 /var/www/html 的权限
RUN chown -R www-data:www-data /var/www/html

# 暴露端口
EXPOSE 80

# 启动 Apache
CMD ["/start.sh"]