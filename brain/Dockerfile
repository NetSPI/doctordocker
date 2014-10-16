FROM ruby:2.1.3
MAINTAINER pjcoole

#RUN /bin/bash -l -c "apt-get update && \
    apt-get install -y curl procps git && \
    rm -rf /var/lib/apt/lists/*"

#RUN /bin/bash -l -c "curl -sSL https://get.rvm.io | bash -s stable && \
    echo 'source /usr/local/rvm/scripts/rvm' >> /etc/bash.bashrc"

#RUN /bin/bash -l -c "rvm install ruby-2.1.3"
# RUN /bin/bash -l -c "gem install bundler"

RUN mkdir -p /usr/src/app

WORKDIR /usr/src/app

ADD Gemfile /usr/src/app/
ADD Gemfile.lock /usr/src/app/
ADD .ruby-version /usr/src/app/

RUN bundle install --system


RUN mkdir -p /home/root/.ssh


ADD . /usr/src/app

RUN cat pub >> /home/root/.ssh/id_rsa.pub

RUN cat priv >> /home/root/.ssh/id_rsa && \
    chmod 500 /home/root/.ssh/id_rsa

RUN mkdir railsgoat

WORKDIR /usr/src/app/railsgoat

RUN git clone https://github.com/pjcoole/railsgoat.git .

WORKDIR /usr/src/app

RUN chmod +x start

CMD ./start
