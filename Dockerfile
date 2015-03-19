# Base on latest CentOS image
FROM centos:latest
MAINTAINER Jonathan Ervine <jon.ervine@gmail.com>
ENV container docker

# Install updates and enable EPEL and repoforge repositories for SABnzbd pre-requisites
RUN yum update -y; yum clean all
RUN yum install -y http://mirror.pnl.gov/epel/7/x86_64/e/epel-release-7-5.noarch.rpm
RUN yum install -y http://pkgs.repoforge.org/rpmforge-release/rpmforge-release-0.5.3-1.el7.rf.x86_64.rpm
RUN yum install -y tar gzip python-cheetah par2cmdline unzip pyOpenSSL unrar supervisor
ADD python-yenc-0.4.0-4.el7.centos.x86_64.rpm /python-yenc-0.4.0-4.el7.centos.x86_64.rpm
RUN yum install -y /python-yenc-0.4.0-4.el7.centos.x86_64.rpm
RUN rm -f /python-yenc-0.4.0-4.el7.centos.x86_64.rpm
RUN yum clean all

# Download and extract SABnzbd from sourceforge
RUN curl http://jaist.dl.sourceforge.net/project/sabnzbdplus/sabnzbdplus/0.7.20/SABnzbd-0.7.20-src.tar.gz > /SABnzbd.tar.gz
RUN tar zxvf /SABnzbd.tar.gz
RUN rm /SABnzbd.tar.gz

ADD supervisord.conf /etc/supervisord.conf
ADD sabnzbd.ini /etc/supervisord.d/sabnzbd.ini

VOLUME /config
VOLUME /downloads

# Start SABnzbd
EXPOSE 8080 9090 9002
ENTRYPOINT ["/usr/bin/supervisord", "-n", -c", "/etc/supervisord.conf"]
