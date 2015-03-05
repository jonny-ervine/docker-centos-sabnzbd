# Base on latest CentOS image
FROM centos:latest
MAINTAINER Jonathan Ervine <jon.ervine@gmail.com>
ENV container docker

# Install updates and EPEL for SABnzbd pre-requisites
RUN yum update -y; yum clean all
RUN yum install -y http://mirror.pnl.gov/epel/7/x86_64/e/epel-release-7-5.noarch.rpm
#RUN yum install -y openssh-server tar gzip python-cheetah python-yenc par2cmdline unzip pyOpenSSL unrar
RUN yum clean all;
#RUN rm -f /etc/ssh/ssh_host_ecdsa_key /etc/ssh/ssh_host_rsa_key && \
#    ssh-keygen -q -N "" -t dsa -f /etc/ssh/ssh_host_ecdsa_key && \
#    ssh-keygen -q -N "" -t rsa -f /etc/ssh/ssh_host_rsa_key
#    sed -i "s/#UsePrivilegeSeparation.*/UsePrivilegeSeparation no/g" /etc/ssh/sshd_config && \
#    sed -i "s/UsePAM.*/UsePAM yes/g" /etc/ssh/sshd_config

RUN echo "root:changeme" | chpasswd

# Start sshd
EXPOSE 22
ENTRYPOINT ["/usr/sbin/sshd", "-D"]
