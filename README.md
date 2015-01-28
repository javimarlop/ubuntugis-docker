ubuntugis-docker
================

[![Gitter](https://badges.gitter.im/Join%20Chat.svg)](https://gitter.im/javimarlop/ubuntugis-docker?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

## Includes:

* Ubuntu 14.04
* GRASS GIS 7
* Python 2.7
* GDAL, GEOS, PROJ
* R
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
useradd -m user
echo -e "docker\ndocker\n" | passwd user
usermod -a -G fuse user
usermod -s /bin/bash user

# start a container
docker run -d -p 27:22 javimarlop/ubuntugis-docker

# connect to it

ssh -X user@0.0.0.0 -p 27 (passw: 'docker')
```
