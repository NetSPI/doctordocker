FROM debian:jessie
MAINTAINER pjcoole

# Install Logstash 1.4.2
RUN apt-get update && \
	DEBIAN_FRONTEND=noninteractive \
    apt-get install -yq \
    openjdk-7-jre-headless \
    wget && \
	rm -rf /var/lib/apt/lists/*

RUN cd /tmp && \
    wget https://download.elasticsearch.org/logstash/logstash/logstash-1.4.2.tar.gz && \
    tar -xzvf ./logstash-1.4.2.tar.gz && \
    mv ./logstash-1.4.2 /opt/logstash && \
    rm ./logstash-1.4.2.tar.gz

RUN /opt/logstash/bin/plugin install contrib


# Copy build files to container root
RUN mkdir /app
ADD . /app
ADD run.sh /usr/local/bin/run

EXPOSE 514
CMD ["/usr/local/bin/run"]
