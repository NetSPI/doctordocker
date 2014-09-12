FROM rails:onbuild
MAINTAINER pjcoole

ONBUILD ADD script/start /start

CMD /start
