FROM debian:jessie

MAINTAINER pjcoole

RUN apt-get update -y && apt-get install -y perl nginx-extras

ADD nginx.conf /etc/nginx.conf

RUN nginx -t -c /etc/nginx/nginx.conf

CMD service nginx start
