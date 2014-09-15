FROM dockerfile/ubuntu
# Install Nginx.
RUN \
add-apt-repository -y ppa:nginx/stable && \
apt-get update && \
apt-get install -y nginx-extras && \
rm -rf /var/lib/apt/lists/* && \
echo "\ndaemon off;" >> /etc/nginx/nginx.conf && \
chown -R www-data:www-data /var/lib/nginx
# Define mountable directories.
VOLUME ["/etc/nginx/sites-enabled", "/etc/nginx/certs", "/etc/nginx/conf.d", "/var/log/nginx"]
# Define working directory.
WORKDIR /etc/nginx
# Define default command.

ADD nginx.conf /etc/nginx/nginx.conf
ADD ./start /start
RUN chmod a+x /start


CMD /start
# Expose ports.
EXPOSE 80
EXPOSE 443
