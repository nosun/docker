FROM ubuntu:14.04
MAINTAINER nosun <nosun2008@126.com>

# upgrade the container
RUN apt-get update && \
    apt-get upgrade -y

# install some prerequisites
RUN apt-get install -y software-properties-common curl build-essential \
    dos2unix gcc git libmcrypt4 libpcre3-dev memcached make python2.7-dev \
    python-pip re2c unattended-upgrades whois vim libnotify-bin nano wget \
    debconf-utils

# add some repositories
RUN apt-add-repository ppa:ondrej/php -y && \
    apt-get update

# set the locale
RUN echo "LC_ALL=en_US.UTF-8" >> /etc/default/locale  && \
    locale-gen en_US.UTF-8  && \
    ln -sf /usr/share/zoneinfo/UTC /etc/localtime

# setup bash
COPY .bash_aliases /root

# install php
RUN apt-get install -y --force-yes php7.0-fpm php7.0-cli php7.0-dev php7.0-pgsql php7.0-sqlite3 php7.0-gd \
    php-apcu php7.0-curl php7.0-mcrypt php7.0-imap php7.0-mysql php7.0-readline php-xdebug php-common \
    php7.0-mbstring php7.0-xml php7.0-zip

# clean up our mess
RUN apt-get remove --purge -y software-properties-common && \
    apt-get autoremove -y && \
    apt-get clean && \
    apt-get autoclean && \
    echo -n > /var/lib/apt/extended_states && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /usr/share/man/?? && \
    rm -rf /usr/share/man/??_*

# PHP config
#ADD php.ini    /usr/local/etc/php/php.ini
#ADD php-fpm.conf    /usr/local/etc/php-fpm.conf

# php.ini
RUN sed -i "s/error_reporting = .*/error_reporting = E_ALL/" /etc/php/7.0/cli/php.ini && \
    sed -i "s/display_errors = .*/display_errors = On/" /etc/php/7.0/cli/php.ini && \
    sed -i "s/;date.timezone.*/date.timezone = UTC/" /etc/php/7.0/cli/php.ini && \
    sed -i "s/error_reporting = .*/error_reporting = E_ALL/" /etc/php/7.0/fpm/php.ini && \
    sed -i "s/display_errors = .*/display_errors = On/" /etc/php/7.0/fpm/php.ini && \
    sed -i "s/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/" /etc/php/7.0/fpm/php.ini && \
    sed -i "s/upload_max_filesize = .*/upload_max_filesize = 100M/" /etc/php/7.0/fpm/php.ini && \
    sed -i "s/post_max_size = .*/post_max_size = 100M/" /etc/php/7.0/fpm/php.ini && \
    sed -i "s/;date.timezone.*/date.timezone = UTC/" /etc/php/7.0/fpm/php.ini;

# php-fpm
RUN sed -i "/listen = .*/c\listen = [::]:9000" /etc/php/7.0/fpm/pool.d/www.conf \
    && sed -i "/;access.log = .*/c\access.log = /proc/self/fd/2" /etc/php/7.0/fpm/pool.d/www.conf \
    && sed -i "/;clear_env = .*/c\clear_env = no" /etc/php/7.0/fpm/pool.d/www.conf \
    && sed -i "/;catch_workers_output = .*/c\catch_workers_output = yes" /etc/php/7.0/fpm/pool.d/www.conf \
    && sed -i "/pid = .*/c\;pid = /run/php/php7.0-fpm.pid" /etc/php/7.0/fpm/php-fpm.conf \
    && sed -i "/;daemonize = .*/c\daemonize = no" /etc/php/7.0/fpm/php-fpm.conf \
    && sed -i "/error_log = .*/c\error_log = /proc/self/fd/2" /etc/php/7.0/fpm/php-fpm.conf;

# xdebug
RUN echo xdebug.remote_enable=1 >> /etc/php/7.0/mods-available/xdebug.ini && \
    echo xdebug.remote_host=127.0.0.1 >> /etc/php/7.0/mods-available/xdebug.ini && \
    echo xdebug.remote_port=9001 >> /etc/php/7.0/mods-available/xdebug.ini && \
    echo xdebug.remote_handler=dbgp >> /etc/php/7.0/mods-available/xdebug.ini && \
    echo xdebug.profiler_enable=1 >> /etc/php/7.0/mods-available/xdebug.ini && \
    echo xdebug.profiler_output_dir="/tmp" >> /etc/php/7.0/mods-available/xdebug.ini \;

# Write Permission
WORKDIR /data/www
RUN usermod -u 1000 www-data

EXPOSE 9000 9001

CMD ["/usr/sbin/php-fpm7.0"]
