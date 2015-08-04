FROM linuxserver/baseimage
MAINTAINER smdion <me@seandion.com>
MAINTAINER Mark Burford <sparklyballs@gmail.com>
MAINTAINER Stian Larsen	<lonix@linuxserver.io>


# expose ports
EXPOSE 80
EXPOSE 443

# set volume
VOLUME /config

# update apt and install nginx
RUN apt-get update && \
apt-get install \
nginx \
php5-fpm \
php5-mysql \
php5 \
php5-cli \
inotify-tools -y && \
apt-get clean -y && \
rm -rf /var/lib/apt/lists/*

#Adduser abc
RUN useradd -u 911 -U -s /bin/false abc
RUN usermod -G users abc

#Adding Custom files
RUN mkdir -p /defaults
ADD defaults/nginx.conf /defaults/nginx.conf 
ADD defaults/nginx-fpm.conf /defaults/nginx-fpm.conf
ADD services/ /etc/service/
ADD init/ /etc/my_init.d/
RUN chmod -v +x /etc/service/*/run
RUN chmod -v +x /etc/my_init.d/*.sh
