#!/bin/bash
CFG=${CFG:-}
ES_HOST=${ES_PORT_9300_TCP_ADDR}
ES_PORT=${ES_PORT_9300_TCP_PORT}
EMBEDDED="false"

if [ "$CFG" != "" ]; then
    wget $CFG -O /opt/logstash.conf --no-check-certificate
else
    cat << EOF > /opt/logstash.conf
input {
  syslog {
    type => syslog
    port => 514
  }
  lumberjack {
    port => 5043
    ssl_certificate => "/opt/certs/logstash-forwarder.crt"
    ssl_key => "/opt/certs/logstash-forwarder.key"
  }
}

output {
  stdout { codec => rubydebug }
EOF
    if [ "$EMBEDDED" = "true" ]; then
        cat << EOF >> /opt/logstash.conf
  elasticsearch { embedded => $EMBEDDED }
}
EOF
    else
        cat << EOF >> /opt/logstash.conf
  elasticsearch { embedded => $EMBEDDED host => "$ES_HOST" port => $ES_PORT }
}
EOF
   fi
fi

/opt/logstash/bin/logstash agent -f /opt/logstash.conf
