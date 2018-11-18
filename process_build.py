import argparse
import subprocess
import os


parser = argparse.ArgumentParser()
parser.add_argument('tag', default='')
args = parser.parse_args()

tag = args.tag

if tag == '':
    if os.getenv('CIRCLE_BRANCH') == 'master':
        tag = 'latest'
    else:
        tag = os.getenv('CIRCLE_BRANCH')
dockerfile_content = """FROM macadmins/sal:{}
MAINTAINER Graham Gilbert <graham@grahamgilbert.com>
ENV DJANGO_SAML_VERSION 0.16.11

RUN apt-get update && apt-get install -y python-setuptools python-dev libxmlsec1-dev libxml2-dev xmlsec1 python-pip
RUN pip install -U setuptools
RUN pip install git+git://github.com/francoisfreitag/djangosaml2.git@613356c7f0e18ecfde07e4d282d0b82b0f4f7268

ADD attributemaps /home/app/sal/sal/attributemaps
RUN mv /home/app/sal/sal/urls.py /home/app/sal/sal/origurls.py
ADD urls.py /home/app/sal/sal/urls.py

""".format(tag)

with open("Dockerfile", "w") as dockerfile:
    dockerfile.write(dockerfile_content)

cmd = [
    'docker',
    'build',
    '-t',
    'macadmins/sal-saml:{}'.format(tag),
    '.'
]

print subprocess.check_output(cmd)

cmd = [
    'docker',
    'login',
    '-u',
    '{}'.format(os.getenv('DOCKER_USER')),
    '-p',
    '{}'.format(os.getenv('DOCKER_PASS'))
]

try:
    print subprocess.check_output(cmd)
except subprocess.CalledProcessError:
    print 'Failed to login to docker'

cmd = [
    'docker',
    'push',
    'macadmins/sal-saml:{}'.format(tag)
]

print subprocess.check_output(cmd)
