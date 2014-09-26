FROM debian:jessie
MAINTAINER Arcus "http://arcus.io"
RUN apt-get update && \
	DEBIAN_FRONTEND=noninteractive apt-get install -y openjdk-7-jre wget && \
	(cd /tmp && wget https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-1.3.2.tar.gz -O pkg.tar.gz && tar zxf pkg.tar.gz && mv elasticsearch-* /opt/elasticsearch) && \
	rm -rf /var/lib/apt/lists/* && \
	rm -rf /tmp/*

ENV JAVA_HOME /usr/lib/jvm/java-6-openjdk-amd64

EXPOSE 9200
EXPOSE 9300
VOLUME /opt/elasticsearch/data
ENTRYPOINT ["/opt/elasticsearch/bin/elasticsearch"]
CMD []
