FROM macadmins/sal:3.3.7
MAINTAINER Graham Gilbert <graham@grahamgilbert.com>
ENV DJANGO_SAML_VERSION 0.16.11

RUN apt-get update && apt-get install -y python-setuptools python-dev libxmlsec1-dev libxml2-dev xmlsec1 python-pip
RUN pip install -U setuptools
RUN pip install git+git://github.com/francoisfreitag/djangosaml2.git@613356c7f0e18ecfde07e4d282d0b82b0f4f7268

ADD attributemaps /home/app/sal/sal/attributemaps
RUN mv /home/app/sal/sal/urls.py /home/app/sal/sal/origurls.py
ADD urls.py /home/app/sal/sal/urls.py
