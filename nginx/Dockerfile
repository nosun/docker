From nginx:1.9

MAINTAINER nosun <nosun2008@126.com>

#ADD nginx.conf /etc/nginx/nginx.conf
ADD sites-enabled/* /etc/nginx/conf.d/
RUN mkdir -p /data/www && mkdir -p /www/log && mkdir -p /data/log/nginx
RUN chown -R www-data.www-data /data/www /data/log

VOLUME ["/data"]
