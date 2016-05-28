FROM phusion/passenger-customizable:0.9.18
MAINTAINER John <john@chaosdevs.com>

# Set correct environment variables.
ENV HOME /root

# Use baseimage-docker's init process.
CMD ["/sbin/my_init"]

RUN curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash - &&\
    sudo apt-get install -y python-setuptools python-dev python2.7 nodejs

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
