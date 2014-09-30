FROM ubuntu
MAINTAINER pjcoole

# Install Nginx.
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys C300EE8C && \
	apt-get update && \
	apt-get install -y wget nginx-common nginx-naxsi && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/*
	rm -rf /tmp/*

RUN echo "daemon off;" >> /etc/nginx/nginx.conf

#fix for long server names
RUN sed -i 's/# server_names_hash_bucket/server_names_hash_bucket/g' /etc/nginx/nginx.conf

RUN wget -P /usr/local/bin https://godist.herokuapp.com/projects/ddollar/forego/releases/current/linux-amd64/forego
RUN chmod u+x /usr/local/bin/forego

RUN wget https://github.com/jwilder/docker-gen/releases/download/0.3.3/docker-gen-linux-amd64-0.3.3.tar.gz
RUN tar -C /usr/local/bin -xvzf docker-gen-linux-amd64-0.3.3.tar.gz

RUN mkdir /app
WORKDIR /app
ADD . /app

EXPOSE 80
ENV DOCKER_HOST unix:///tmp/docker.sock

RUN echo *.* @@33.33.33.60:514 >> /etc/rsyslog.d/50-default.conf && \
	rsyslogd

CMD ["forego", "start", "-r"]
