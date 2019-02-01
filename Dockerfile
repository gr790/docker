FROM centos:centos7.5.1804

MAINTAINER Rahul Gupta "rahulroot@gmail.com"

RUN yum install -y \
    epel-release \
    openssl-devel \
    readline-devel\
    zlib-devel \
    wget \
    curl \
    git \
    vim \
    bzip2 \
    tar \
    libffi-devel \
    augeas-devel \
    libxml-devel \
    libxslt-devel \
&&  yum groupinstall "Development Tools" -y \
&&  yum clean all

RUN git clone git://github.com/rbenv/rbenv.git /opt/rbenv \
&&  git clone git://github.com/rbenv/ruby-build.git /opt/rbenv/plugins/ruby-build \
&&  git clone git://github.com/jf/rbenv-gemset.git /opt/rbenv/plugins/rbenv-gemset \
&&  /opt/rbenv/plugins/ruby-build/install.sh
ENV PATH /opt/rbenv/bin:$PATH
ENV RBENV_ROOT /opt/rbenv

RUN echo 'export RBENV_ROOT=/opt/rbenv' >> /etc/profile.d/rbenv.sh \
&&  echo 'export PATH=/opt/rbenv/bin:$PATH' >> /etc/profile.d/rbenv.sh \
&&  echo 'eval "$(rbenv init -)"' >> /etc/profile.d/rbenv.sh

RUN echo 'export RBENV_ROOT=/opt/rbenv' >> /root/.bashrc \
&&  echo 'export PATH=/opt/rbenv/bin:$PATH' >> /root/.bashrc \
&&  echo 'eval "$(rbenv init -)"' >> /root/.bashrc

ENV CONFIGURE_OPTS --disable-install-doc
ENV PATH /opt/rbenv/bin:/opt/rbenv/rbenv/shims:$PATH

ENV RBENV_VERSION 2.5.3

RUN eval "$(rbenv init -)"; rbenv install $RBENV_VERSION \
&&  eval "$(rbenv init -)"; rbenv global $RBENV_VERSION \
&&  eval "$(rbenv init -)"; gem update --system \
&&  eval "$(rbenv init -)"; gem install bundler -v 1.17.3 -f \
&&  rm -rf /tmp/*
