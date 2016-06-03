FROM phusion/passenger-customizable:0.9.18
MAINTAINER John <john@chaosdevs.com>

# Set correct environment variables.
ENV HOME /root

# Use baseimage-docker's init process.
CMD ["/sbin/my_init"]

#RUN rm /bin/sh && ln -s /bin/bash /bin/sh
#
#RUN apt-get update &&\
#    apt-get install -yq &&\
#    git build-essential python-setuptools python python-dev python-pip libffi-dev &&\
#    libssl-dev ca-certificates nodejs lsof &&\
#    curl https://nodejs.org/dist/v5.10.1/node-v5.10.1-linux-x64.tar.gz | tar xvzf - -C /opt/nodejs --strip-components=1 &&\
#    ln -s /opt/nodejs/bin/node /usr/bin/node &&\
#    ln -s /opt/nodejs/bin/npm /usr/bin/npm
#
#RUN curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash - &&\
#    sudo apt-get install -y python-setuptools python-dev python2.7 nodejs

RUN rm /bin/sh && ln -s /bin/bash /bin/sh

# Set debconf to run non-interactively
#RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

# Install base dependencies
RUN apt-get update && apt-get install -y -q --no-install-recommends \
        apt-transport-https \
        build-essential \
        ca-certificates \
        curl \
        git \
        python-setuptools python python-dev python-pip libffi-dev libssl-dev \
        rsync \
        software-properties-common \
        wget \
    && rm -rf /var/lib/apt/lists/*

ENV NVM_DIR /usr/local/nvm/versions/node
ENV NODE_VERSION 6.2.0

# Install nvm with node and npm
RUN curl https://raw.githubusercontent.com/creationix/nvm/v0.31.0/install.sh | bash \
    && source $NVM_DIR/nvm.sh \
    && nvm install $NODE_VERSION \
    && nvm alias default $NODE_VERSION \
    && nvm use default

ENV NODE_PATH $NVM_DIR/versions/node/v$NODE_VERSION/lib/node_modules
ENV PATH      $NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH


# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
