FROM macadmins/sal:latest
MAINTAINER Graham Gilbert <graham@grahamgilbert.com>
ENV DJANGO_SAML_VERSION 0.16.11

RUN apt-get update && apt-get install -y python-setuptools python-dev libxmlsec1-dev libxml2-dev xmlsec1 python-pip
RUN pip install -U setuptools
RUN pip install git+git://github.com/knaperek/djangosaml2.git@809f94a43faa7b9b5d3753609b8fa05d225f4d0b

ADD attributemaps /home/app/sal/sal/attributemaps
RUN mv /home/app/sal/sal/urls.py /home/app/sal/sal/origurls.py
ADD urls.py /home/app/sal/sal/urls.py
