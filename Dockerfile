FROM centos

MAINTAINER [Alejandro Baez](https://twitter.com/a_baez)

# Dependencies
RUN yum install -y git vim curl

# Build Dev Essentials
RUN yum install -y tar make perl-CPAN bzip2 patch gcc automake autoconf
RUN yum install -y openssl openssl-devel

# Environment
ENV SHELL /bin/bash
ENV HOME /root
ENV PERLBREW_ROOT /usr/local/perlbrew
ENV PERLBREW_HOME /root/.perlbrew

# Set desired Perl
ENV TARGET_PERL_FULL 5.16.3
ENV TARGET_PERL 5.16

# Install perlbrew
RUN cpan App::cpanminus
RUN cpanm install Pod::Usage --force # 1.64
RUN cpanm install App::perlbrew

# Reinstall cpanm for perlbrew
RUN perlbrew install-patchperl
RUN perlbrew install-cpanm

# download perl version
RUN mkdir -p /usr/local/perlbrew/dists/ /usr/local/perlbrew/build
RUN curl -o /usr/local/perlbrew/dists/perl-$TARGET_PERL_FULL.tar.bz2 \
  http://www.cpan.org/src/5.0/perl-$TARGET_PERL_FULL.tar.bz2
RUN perlbrew install --as $TARGET_PERL $TARGET_PERL_FULL
RUN rm -rf /usr/local/perlbrew/build/* \
  /usr/local/perlbrew/dists/perl-$TARGET_PERL_FULL.tar.bz2

# Install perl target version
RUN perlbrew switch $TARGET_PERL

ENV PATH /usr/local/perlbrew/perls/$TARGET_PERL/bin:$PATH
ENV MANPATH /usr/local/perlbrew/perls/$TARGET_PERL/man
ENV PERLBREW_MANPATH /usr/local/perlbrew/perls/$TARGET_PERL/man
ENV PERLBREW_PATH /usr/local/perlbrew/bin:/usr/local/perlbrew/perls/$TARGET_PERL/bin
ENV PERLBREW_PERL $TARGET_PERL

RUN cpanm -n App::DuckPAN --force

# Install ddg
RUN duckpan DDG

