# Base on latest CentOS image
FROM centos:latest
MAINTAINER Jonathan Ervine <jon.ervine@gmail.com>
ENV container docker

# Install updates and enable EPEL and repoforge repositories for SABnzbd pre-requisites
RUN yum update -y; yum clean all
RUN yum install -y http://mirror.pnl.gov/epel/7/x86_64/e/epel-release-7-5.noarch.rpm
RUN yum install -y http://pkgs.repoforge.org/rpmforge-release/rpmforge-release-0.5.3-1.el7.rf.x86_64.rpm
RUN yum install -y openssh-server tar gzip python-cheetah par2cmdline unzip pyOpenSSL unrar
RUN yum clean all;
RUN ssh-keygen -q -N "" -t dsa -f /etc/ssh/ssh_host_ecdsa_key && \
    ssh-keygen -q -N "" -t rsa -f /etc/ssh/ssh_host_rsa_key
#    sed -i "s/#UsePrivilegeSeparation.*/UsePrivilegeSeparation no/g" /etc/ssh/sshd_config && \
#    sed -i "s/UsePAM.*/UsePAM yes/g" /etc/ssh/sshd_config

RUN echo "root:changeme" | chpasswd

# Start sshd
EXPOSE 22
ENTRYPOINT ["/usr/sbin/sshd", "-D"]
