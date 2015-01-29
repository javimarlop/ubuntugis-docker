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

RUN dpkg-divert --local --rename --add /sbin/initctl && ln -sf /bin/true /sbin/initctl

RUN apt-get install -y --force-yes build-essential language-pack-en* curl iputils-ping fuse libfuse-dev libfuse2 git mc sshfs python-setuptools python-dev libpython-dev python-pip software-properties-common python-numpy libgdal-dev python-gdal gdal-bin libproj0 libproj-dev python-pyproj libgeos-* nano wget git dialog libgdal1-dev  libgdal1h grass-core python-matplotlib python-pandas python-sympy python-scipy python-nose libblas-dev liblapack-dev gfortran ipython ipython-notebook #libgdal1-1.10.1-grass

#RUN pip install ipython ipython-notebook --upgrade
RUN pip install scikit-learn #--upgrade
#RUN pip install numpy --upgrade
#RUN pip install scipy --upgrade
#RUN pip install gdal --upgrade

# Java
RUN apt-get install -y default-jre-headless default-jre 

# GRASS GIS 7 and R

#RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9

RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9 

#RUN gpg --keyserver keyserver.ubuntu.com --recv-key E084DAB9
#RUN gpg -a --export E084DAB9 | sudo apt-key add -

RUN apt-get install -y --force-yes flex firefox openssh-server bison libtiff4-dev mesa-common-dev libglu-dev  libfftw3-* libcairo2-dev python-gtk2 python-gtk2-dbg python-gtk2-dev python-wxgtk* grass70-* r-base r-base-dev r-cran-xml libapparmor1 gdebi-core xserver-xorg xdm xterm

# Configuring xdm to allow connections from any IP address and ssh to allow X11 Forwarding.
RUN sed -i 's/DisplayManager.requestPort/!DisplayManager.requestPort/g' /etc/X11/xdm/xdm-config
RUN sed -i '/#any host/c\*' /etc/X11/xdm/Xaccess
#RUN ln -s /usr/bin/Xorg /usr/bin/X # not working

RUN echo "local({r <- getOption('repos');r['CRAN'] <- 'http://cran.rstudio.com/';options(repos = r)})" > /etc/R/Rprofile.site

# ipython notebook
RUN apt-get update && apt-get install -y -q \
    make \
    gcc \
    zlib1g-dev \
    python \
    python-sphinx \
    python3-sphinx \
    libzmq3-dev \
    sqlite3 \
    libsqlite3-dev \
    pandoc \
    libcurl4-openssl-dev \
    nodejs \
    nodejs-legacy

# ipython notebook

RUN apt-get update
RUN apt-get upgrade -y

RUN echo LANG="en_US.UTF-8" > /etc/default/locale
COPY ./sshd /etc/pam.d/sshd
COPY ./ssh_config /etc/ssh/ssh_config

#RUN echo X11Forwarding yes >> /etc/ssh/ssh_config # not working

EXPOSE 22
EXPOSE 8888

RUN mkdir /var/run/sshd

RUN /etc/init.d/xdm restart
#RUN service ssh restart



