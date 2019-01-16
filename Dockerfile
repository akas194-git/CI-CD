FROM centos:centos6
MAINTAINER akas
RUN yum update -y && yum install -y httpd net-tools
COPY ./src var/www/html
ENTRYPOINT apachectl "-DFOREGROUND"


