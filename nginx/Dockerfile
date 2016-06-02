From nginx:1

MAINTAINER nosun <nosun2008@126.com>

ADD nginx.conf /etc/nginx/nginx.conf
ADD sites-enabled/* /etc/nginx/sites-enabled/
RUN mkdir -p /data/www && mkdir -p /data/logs/nginx

WORKDIR /data/www
RUN usermod -u 1000 www-data

VOLUME ["/data/www"]
