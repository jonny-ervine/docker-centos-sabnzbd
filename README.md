# docker-centos-sabnzbd
## SABnzbd running on the latest CentOS docker image (7.0)

The Dockerfile should intialise the CentOS image and subscribe to the EPEL and repoforge repositories. The pre-requisites for SABnzbd are then installed via yum.

The EPEL repository provides:

    tar gzip python-cheetah par2cmdline unzip pyOpenSSL

The repoforge (formerly RPMForge) provides:

    unrar

SABnzbd is optimised to use python-yenc, however this package is not available in any CentOS 7 repositories at the moment. A pre-compiled binary RPM of python-yenc-0.4.0-4 has been provided for CentOS 7. This pre-compiled binary RPM was built from the Fedora 22 src.rpm (currently in rawhide).

The SABnzbd daemon is controlled via the supervisord daemon which has a web front end exposed via port 9002. Default username and password for the web front end is admin:admin.

The SABnzbd software package is downloaded as a tarball from sourceforge and then extracted into the docker container ready for use.

The container can be run as follows:

    docker pull jervine/docker-centos-sabnzbd
    docker run -d -n <optional name of container> -h <optional host name of container> -e TZ="<optional timezone> -v /<config directory on host>:/config -v /<download directory on host>:/downloads -p 8080:8080 -p 9090:9090 -p 9002:9002 jervine/docker-centos-sabnzbd

THe TZ variable allows the user to set the correct timezone for the container and should take the form "Europe/London". If no timezone is specified then UTC is used by default. The timezone is set up when the container is run. Subsequent stops and starts will not change the timezone.

The container can be verified on the host by using:

    docker logs <container id/container name>
and/or:

    cat /<config directory on host>/logs/sabnzbd.log

Please note that the SELinux permissions of the config and downloads directories may need to be changed/corrected as necessary.
