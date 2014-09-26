FROM frodenas/java7
MAINTAINER pjcoole

# Install Logstash 1.4.2
RUN cd /tmp &amp;&amp; \
    wget https://download.elasticsearch.org/logstash/logstash/logstash-1.4.2.tar.gz &amp;&amp; \
    tar xvzf logstash-1.4.2.tar.gz &amp;&amp; \
    mv /tmp/logstash-1.4.2 /logstash &amp;&amp; \
    apt-get clean &amp;&amp; rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ADD run.sh /usr/local/bin/run
RUN chmod +x /usr/local/bin/run
RUN rm -rf /tmp/*

EXPOSE 514
EXPOSE 9200
EXPOSE 9292
EXPOSE 9300
CMD ["/usr/local/bin/run"]
