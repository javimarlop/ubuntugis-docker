FROM ubuntu:14.04

# Connect to ubuntugis and R latest

RUN echo "deb http://cran.rstudio.com/bin/linux/ubuntu trusty/  " >> /etc/apt/sources.list
RUN echo "deb http://ppa.launchpad.net/ubuntugis/ubuntugis-unstable/ubuntu trusty main " >> /etc/apt/sources.list
RUN echo "deb-src http://ppa.launchpad.net/ubuntugis/ubuntugis-unstable/ubuntu trusty main " >> /etc/apt/sources.list
#RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 314DF160

COPY ./key /tmp/key
COPY ./key2 /tmp/key2

RUN apt-key add /tmp/key
RUN apt-key add /tmp/key2

RUN echo "deb http://ppa.launchpad.net/grass/grass-devel/ubuntu trusty main " >> /etc/apt/sources.list
RUN echo "deb-src http://ppa.launchpad.net/grass/grass-devel/ubuntu trusty main " >> /etc/apt/sources.list
#RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 26D57B27

# update apt cache and upgrade
RUN apt-get update
RUN apt-get upgrade -y

# Install Utilities
RUN apt-get install -y --force-yes build-essential curl iputils-ping fuse fuse-utils libfuse-dev libfuse2 git mc sshfs python-setuptools python-dev python-pip software-properties-common python-numpy libgdal-dev python-gdal gdal-bin libproj0 libproj-dev python-pyproj libgeos-* nano wget git dialog libgdal1-dev  libgdal1h grass-core python-matplotlib python-pandas python-sympy python-nose libblas-dev liblapack-dev gfortran libgdal1-*#1.10.0-grass

RUN pip install ipython ipython-notebook
RUN pip install scikit-learn
RUN pip install numpy --upgrade
RUN pip install scipy

# Java
RUN apt-get install -y default-jre-headless default-jre 

# GRASS GIS 7 and R

#RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9

RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9 

#RUN gpg --keyserver keyserver.ubuntu.com --recv-key E084DAB9
#RUN gpg -a --export E084DAB9 | sudo apt-key add -

RUN apt-get install -y --force-yes flex firefox openssh-server bison libtiff4-dev mesa-common-dev libglu-dev  libfftw3-* libcairo2-dev python-gtk2 python-gtk2-dbg python-gtk2-dev python-wxgtk* grass70-* r-base r-base-dev r-cran-xml libapparmor1 gdebi-core xserver-xorg xdm

# Configuring xdm to allow connections from any IP address and ssh to allow X11 Forwarding.
RUN sed -i 's/DisplayManager.requestPort/!DisplayManager.requestPort/g' /etc/X11/xdm/xdm-config
RUN sed -i '/#any host/c\*' /etc/X11/xdm/Xaccess
RUN ln -s /usr/bin/Xorg /usr/bin/X
RUN echo X11Forwarding yes >> /etc/ssh/ssh_config

RUN echo "local({r <- getOption('repos');r['CRAN'] <- 'http://cran.rstudio.com/';options(repos = r)})" > /etc/R/Rprofile.site

RUN useradd -m user
RUN usermod -a -G fuse user
RUN usermod -s /bin/bash user

RUN apt-get update
RUN apt-get upgrade -y

EXPOSE 22

RUN mkdir /var/run/sshd

RUN /etc/init.d/xdm restart
RUN /usr/sbin/sshd -D


