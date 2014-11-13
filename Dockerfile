FROM ubuntu:12.04

# Connect to ubuntugis and R latest

RUN echo "deb http://cran.rstudio.com/bin/linux/ubuntu precise/  " >> /etc/apt/sources.list
RUN echo "deb http://ppa.launchpad.net/ubuntugis/ubuntugis-unstable/ubuntu precise main " >> /etc/apt/sources.list
RUN echo "deb-src http://ppa.launchpad.net/ubuntugis/ubuntugis-unstable/ubuntu precise main " >> /etc/apt/sources.list
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 314DF160

RUN echo "deb http://ppa.launchpad.net/grass/grass-devel/ubuntu precise main " >> /etc/apt/sources.list
RUN echo "deb-src http://ppa.launchpad.net/grass/grass-devel/ubuntu precise main " >> /etc/apt/sources.list
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 26D57B27

# update apt cache and upgrade
RUN apt-get update
RUN apt-get upgrade -y

# Install Utilities
RUN apt-get install --force-yes build-essential curl iputils-ping fuse fuse-utils libfuse-dev libfuse2 git mc sshfs python-setuptools python-dev python-pip python-software-properties python-numpy python-scipy libgdal-dev python-gdal gdal-bin libproj0 libproj-dev python-pyproj libgeos-3.4.2 libgeos-dev nano wget git dialog libgdal1-dev  libgdal1h grass-core # libgdal1-1.10.0-grass

RUN pip install scikit-learn

# Java
RUN apt-get install -y default-jre 

# GRASS GIS 7

RUN apt-get install --force-yes flex  bison libtiff4-dev mesa-common-dev libglu-dev  libfftw3-dev  libfftw3-dev libfftw3-3 libfftw3-dev  libcairo2-dev python-gtk2 python-gtk2-dbg python-gtk2-dev python-wxgtk2.6 python-wxgtk2.6-dbg python-wxgtk2.8 python-wxgtk2.8-dbg grass70-core  grass70-dev grass70-dev-doc grass70-doc r-base r-base-dev r-cran-xml #libapparmor1 gdebi-core

RUN echo "local({r <- getOption('repos');r['CRAN'] <- 'http://cran.rstudio.com/';options(repos = r)})" > /etc/R/Rprofile.site

RUN useradd -m user
RUN usermod -a -G fuse user
RUN usermod -s /bin/bash user

