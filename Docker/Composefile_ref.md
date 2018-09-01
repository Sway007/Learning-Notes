## Overview

- Compose file is a YAML file defining services, networks and volumes
- `./docker-compose.yml`
- services/networks/volumes
  - services: `docker container create`
  - networks: `docker network create`
  - volumes: `docker volume create`
- as with `docker create`, options specified in Dockerfile is default - no need to specify in `docker-compose.yml`

## Commands

- BUILD
    - a string containing a path to the build context:
    ```yaml
    version: '3'
    services:
        webapp:
            build: ./dir
    ``` 
    - an object with the path specified under context and optionally Dockerfile and args:
    ```yaml
    version: '3'
    services:
        webapp:
            build:
                context: ./dir
                dockerfile: Dockerfile-alternate
                args:
                    buildno: 1
    ```
- CONTEXT
    - a path to a directory containing a Dockerfile, or a url to a git repository.
    - path relative to the location of the Compose file

- ARGS
    - build arguments, which are environment variables accessible only during the build process.
    [ref link](https://docs.docker.com/compose/compose-file/#dockerfile)
        - first specify in Dockerfile
        ```dockerfile
        ARG buildno
        ARG gitcommithash

        RUN echo "Build number: $buildno"
        RUN echo "Based on commit: $gitcommithash"
        ``` 
        - then specify args in `build` key, passing a map or list:
        ```yaml
        build:
        context: .
        args:
            buildno: 1
            gitcommithash: cdc3b19

        build:
        context: .
        args:
            - buildno=1
            - gitcommithash=cdc3b19
        ``` 
- command
    - Override the default command.