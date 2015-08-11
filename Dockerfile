FROM centos

MAINTAINER [Alejandro Baez](https://twitter.com/a_baez)

# Install EPEL
#RUN yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm

# Dependencies
RUN yum install -y git vim curl

# Build Dev Essentials
RUN yum install -y tar make perl-CPAN
#RUN yum groupinstall "Development Tools"

ENV SHELL /bin/bash
ENV HOME /root
ENV PERLBREW_ROOT /usr/local/perlbrew
ENV PERLBREW_HOME /root/.perlbrew

RUN curl -L http://install.perlbrew.pl | bash

RUN cpanm -n App::DuckPAN

#ADD add/install.pl /tmp/install.pl
#RUN perl /tmp/install.pl || echo "running again"
#RUN perl -I/root/perl5/lib/perl5 -Mlocal::lib
#RUN perl /tmp/install.pl
