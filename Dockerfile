FROM ghcr.io/salopensource/sal-saml:latest
ENV APP_DIR=/home/docker/sal
RUN apt-get update && apt-get install -y python3-setuptools python3-dev libxmlsec1-dev libxml2-dev xmlsec1 python3-pip
RUN pip3 install -U setuptools
RUN pip3 install djangosaml2==0.18.1

ADD attributemaps /home/app/sal/sal/attributemaps
RUN mv ${APP_DIR}/sal/urls.py ${APP_DIR}/sal/origurls.py
ADD urls.py ${APP_DIR}/sal/urls.py