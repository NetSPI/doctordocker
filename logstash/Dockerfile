FROM debian:jessie
MAINTAINER pjcoole

ENV LUMBERJACK_TAG MYTAG
ENV ELASTICWORKERS 1

# Install Logstash 1.4.2
RUN apt-get update && \
	DEBIAN_FRONTEND=noninteractive \
    apt-get install -yq \
    openjdk-7-jre-headless \
    wget && \
    apt-get clean && \
	rm -rf /var/lib/apt/lists/*

RUN cd /tmp && \
    wget https://download.elasticsearch.org/logstash/logstash/logstash-1.4.2.tar.gz && \
    tar -xzvf ./logstash-1.4.2.tar.gz && \
    mv ./logstash-1.4.2 /opt/logstash && \
    rm ./logstash-1.4.2.tar.gz

RUN /opt/logstash/bin/plugin install contrib

RUN mkdir /opt/certs/ && mkdir /mnt/logstash-forwarder
ADD certs/logstash-forwarder.crt /opt/certs/logstash-forwarder.crt
ADD certs/logstash-forwarder.key /opt/certs/logstash-forwarder.key
ADD certs/logstash-forwarder.crt /mnt/logstash-forwarder/logstash-forwarder.crt
ADD certs/logstash-forwarder.key /mnt/logstash-forwarder/logstash-forwarder.key
ADD collectd-types.db /opt/collectd-types.db

# Copy build files to container root
RUN mkdir /app 
ADD . /app
ADD run.sh /usr/local/bin/run

EXPOSE 514
EXPOSE 5043
CMD ["/usr/local/bin/run"]
