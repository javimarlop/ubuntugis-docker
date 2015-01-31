ubuntugis-docker
================

[![Gitter](https://badges.gitter.im/Join%20Chat.svg)](https://gitter.im/javimarlop/ubuntugis-docker?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

## Includes:

* Ubuntu 14.04
* GRASS GIS 6.4 and 7.0
* QGIS
* Python 2.7 and 3
* GDAL, GEOS, PROJ
* R
* pktools (Processing Kernel for remote sensing data)
* OpenCPU Server
* IPython Notebook
* SSH + X display

## Get/Build it

```
docker pull javimarlop/ubuntugis-docker

# or clone the repository, open a terminal into it and build it:

sudo docker build --tag="ubuntugis-docker" .
```

## Use it

```
# previously create a new user

docker run -ti -p 27:22 -p 8888:8888 javimarlop/ubuntugis-docker /bin/bash
useradd -m user
echo -e "changeme\nchangeme\n" | passwd user
usermod -a -G fuse user
usermod -s /bin/bash user

service opencpu restart # if you want to run OpenCPU
http://xxx.xx.x.x/ocpu/ # to test it on your host's browser (you can get the IP address using: docker inspect "container_name"

# connect to it

/usr/sbin/sshd -e # to start the ssh service
ssh -X user@0.0.0.0 -p 27 #(passw: 'changeme')

# to run the ipyhton notebook

ipython notebook --ip=0.0.0.0 --port=8888 --pylab=inline --no-browser &
http://0.0.0.0:8888/ # on your host's browser

```
