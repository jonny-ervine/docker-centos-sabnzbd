# docker-centos-sabnzbd
SABnzbd running on the latest CentOS docker image (7.0)

The Dockerfile should intialise the CentOS image and subscribe to the EPEL and repoforge repositories. The pre-requisites for SABnzbd are then installed via yum.

The EPEL repository provides:
tar gzip python-cheetah par2cmdline unzip pyOpenSSL

The repoforge (formerly RPMForge) provides:
unrar

SABnzbd is optimised to use python-yenc, however this package is not available in any CentOS 7 repositories at the moment. A pre-compiled binary RPM of python-yenc-0.4.0-4 has been provided for CentOS 7. This pre-compiled binary RPM was built from the Fedora 22 src.rpm (currently in rawhide).

The SABnzbd software package is downloaded as a tarball from sourceforge and then extracted into the docker container ready for use.
