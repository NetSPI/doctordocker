FROM debian:jessie
MAINTAINER pjcoole

RUN apt-get update && \
    apt-get install -y curl procps git && \
    rm -rf /var/lib/apt/lists/*


RUN /bin/bash -l -c "curl -sSL https://get.rvm.io | bash -s stable && \
    echo 'source /usr/local/rvm/scripts/rvm' >> /etc/bash.bashrc"

RUN /bin/bash -l -c "rvm install ruby-2.1.3"
# RUN /bin/bash -l -c "gem install bundler"

RUN mkdir -p /usr/src/app

WORKDIR /usr/src/app

ADD Gemfile /usr/src/app/
ADD Gemfile.lock /usr/src/app/
ADD .ruby-version /usr/src/app/

user root

RUN /bin/bash -l -c "bundle install"

ADD . /usr/src/app

RUN chmod +x start

user root

CMD /bin/bash -l -c "./start"
