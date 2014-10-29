FROM ubuntu:14.04

# Connect to ubuntugis

RUN echo "deb http://ppa.launchpad.net/ubuntugis/ubuntugis-unstable/ubuntu trusty main " >> /etc/apt/sources.list
RUN echo "deb-src http://ppa.launchpad.net/ubuntugis/ubuntugis-unstable/ubuntu trusty main "  >> /etc/apt/sources.list
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 314DF160

#RUN echo "deb http://ppa.launchpad.net/grass/grass-devel/ubuntu precise main " >> /etc/apt/sources.list
#RUN echo "deb-src http://ppa.launchpad.net/grass/grass-devel/ubuntu precise main " >> /etc/apt/sources.list
#RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 26D57B27

# update apt cache and upgrade
RUN apt-get update
RUN apt-get upgrade -y

# Install Utilities
RUN apt-get install -y curl git mc build-essential python-setuptools python-dev python-pip python-software-properties python-numpy python-scipy libgdal-dev python-gdal gdal-bin libproj0 libproj-dev python-pyproj libgeos-3.2.2 libgeos-dev nano wget git dialog

RUN pip install scikit-learn

# Java
RUN apt-get install -y default-jre 

# GRASS GIS 7

RUN add-apt-repository -y ppa:grass/grass-stable
RUN apt-get update
RUN apt-get install grass70 grass70-gui

#RUN apt-get install -y grass70 grass70-doc grass70-core grass70-gui grass70-dev