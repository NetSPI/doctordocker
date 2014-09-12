FROM debian:jessie

MAINTAINER= pjcoole

RUN apt-get update && apt-get install -y --no-install-recommends \
		fontconfig-config \
		fonts-dejavu-core \
		geoip-database \
		init-system-helpers \
		libarchive-extract-perl \
		libexpat1 \
		libfontconfig1 \
		libfreetype6 \
		libgcrypt11 \
		libgd3 \
		libgdbm3 \
		libgeoip1 \
		libgpg-error0 \
		libjbig0 \
		libjpeg8 \
		liblog-message-perl \
		liblog-message-simple-perl \
		libmodule-pluggable-perl \
		libpng12-0 \
		libpod-latex-perl \
		libssl1.0.0 \
		libterm-ui-perl \
		libtext-soundex-perl \
		libtiff5 \
		libvpx1 \
		libx11-6 \
		libx11-data \
		libxau6 \
		libxcb1 \
		libxdmcp6 \
		libxml2 \
		libxpm4 \
		libxslt1.1 \
		perl \
		perl-modules \
		rename \
		sgml-base \
		ucf \
		xml-core \
    libcurl4-gnutls-dev \
    libexpat1-dev \
    gettext \
    libz-dev \
    libssl-dev \
    build-essential \
    git-core \
	  && rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/SpiderLabs/ModSecurity.git mod_security && cd mod_security ./autogen.sh && ./configure --enable-standalone-module && make \

    && wget http://www.nginx.org/download/nginx-1.7.4.tar.gz && tar -xvpzf nginix-1.7.4.tar.gz && ./configure --add-module=../mod_security/nginx/modsecurity && make && make install

ADD nginx.conf /nginx.conf
ADD modsecurity.conf /modsecurity.conf

RUN service nginx stop

CMD service nginx start
