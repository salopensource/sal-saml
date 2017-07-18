FROM macadmins/sal:3.2.2
MAINTAINER Graham Gilbert <graham@grahamgilbert.com>
ENV DJANGO_SAML_VERSION 0.14.4

RUN apt-get update && apt-get install -y python-setuptools python-dev libxmlsec1-dev libxml2-dev xmlsec1 \
    && easy_install pip \
    && pip install djangosaml2==$DJANGO_SAML_VERSION

ADD attributemaps /home/app/sal/sal/attributemaps
RUN mv /home/app/sal/sal/urls.py /home/app/sal/sal/origurls.py
ADD urls.py /home/app/sal/sal/urls.py
