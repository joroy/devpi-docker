FROM ubuntu:14.04
MAINTAINER Jonathan Roy <jonathan.roy@cadensimaging.com>

#RUN echo "deb http://archive.ubuntu.com/ubuntu trusty main universe multiverse" > /etc/apt/sources.list \ 
# && apt-get update -qq

RUN apt-get update
RUN apt-get install -y wget python2.7 python2.7-dev 

# Install latest pip
RUN wget https://bootstrap.pypa.io/get-pip.py
RUN python2.7 get-pip.py

RUN apt-get install -y supervisor 
RUN apt-get install -y nginx
RUN pip install -U virtualenv

RUN virtualenv -q /opt/devpi
RUN . /opt/devpi/bin/activate \
 && pip install devpi

ADD nginx.conf /etc/nginx/sites-enabled/default
RUN echo "daemon off;" >> /etc/nginx/nginx.conf
ADD supervisor.conf /etc/supervisor/conf.d/devpi.conf

EXPOSE 80
CMD /usr/bin/supervisord -n
