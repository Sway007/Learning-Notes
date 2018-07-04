# Docker

## image build

The `docker build` command builds an image from a `Dockerfile` and a `context`.  

The build’s context is the set of files at a specified location `PATH` or `URL`. The `PATH` is a directory on your local filesystem. The `URL` is a Git repository location.

Traditionally, the `Dockerfile` is called `Dockerfile` and located in the root of the context. You use the `-f` flag with `docker build` to point to a Dockerfile anywhere in your file system.

```
$ docker build -f /path/to/a/Dockerfile .  
$ docker build -f dockerfilepath contextpath
```

links:[Dockerfile reference](https://docs.docker.com/engine/reference/builder/)

----------------

## Overview

- A container is *launched* by running an image.
- An image is an executable package that includes everything needed to run an application.
- A container is a runtime instance of an image
- hierarchy of docker app:

    * Stack
    * Services
    * Container

## Container

- Images are defined by `Dockerfile`
- Access to resources in container by networking interfaces
- Create an image by `docker build`

## Service

- compose a container group by `docker-compose.yml`  
    #TODO: fix me
- 