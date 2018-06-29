# Dockerfile

## Usage

- `docker build` 

    build an image from a `Dockerfile` **and** a _contenx_.  
    - contenx is the set of files in a directory on your local filesystem or a Git repository location.
    - `.dockerignore`: exclude files and directories
    - flags
        - `f`: specify `Dockerfile` location
        - `t`: tag the image built
    - each instruction is run independently, so `RUN cd /tmp` will not have any effect on the next instructions.

## Format

```
# Comment
INSTRUCTION arguments
```

- `Dockerfile` must start with a `FROM` instruction
    - `FROM`: specify the Base Image from which buid.

## Environment replacement

- Environment variables are declared with `ENV` statement
- denoted by `$variable_name` or `${variable_name}`

## .dockerignore file

- for performance enhancement:

    efore the docker CLI sends the context to the docker daemon, it looks for a file named .dockerignore in the root directory of the context. If this file exists, the CLI modifies the context to exclude files and directories that match patterns in it. This helps to avoid unnecessarily sending large or sensitive files and directories to the daemon and potentially adding them to images using ADD or COPY.

- Matching is done using [Go’s filepath.Match](http://golang.org/pkg/path/filepath#Match) rules.

## Instrctions

### From
```Dockerfile
FROM <image> [AS <name>]
FROM <image>[:<tag>] [AS <name>]
FROM <image>[@<digest>] [AS <name>]
```

### RUN

```Dockerfile
RUN <command>   # shell form
RUN ["executable", "param1", "param2"]  # unix exec form
```

- the `RUN` resulting committed image will be used for the next step in the `Dockerfile`
- The _exec_ form makes it possible to avoid shell string munging, and to RUN commands using a base image that does not contain the specified shell executable.

### CMD
```Dockerfile
CMD ["executable","param1","param2"] #(exec form, this is the preferred form)
CMD ["param1","param2"] #(as default parameters to ENTRYPOINT)
CMD command param1 param2 #(shell form)
```
- There can only be one CMD instruction in a Dockerfile. If you list more than one CMD then only the last CMD will take effect.
- The main purpose of a CMD is to provide defaults for an executing container.
- defference betweem `RUN` and `CMD`

    > `RUN` actually runs a command and commits the result; `CMD` does not execute anything at build time, but specifies the intended command for the image.

### LABLE

```
LABEL <key>=<value> <key>=<value> <key>=<value> ...
```

The LABEL instruction adds metadata to an image.

- use `docker inspect` to view an image's lables.

### EXPOSE

```dockerfile
EXPOSE <port> [<port>/<protocol>...]
```

- `EXPOSE` instruction informs Docker that the container listens on the specified network ports at runtime.

### ENV

```dockerfile
ENV <key> <value>
ENV <key>=<value> ...
```
sets the environment variable <key> to the value <value>. This value will be in the environment of all “descendant” Dockerfile commands 

### ADD
```Dockerfile
ADD <src>... <dest>
ADD ["<src>",... "<dest>"] #(this form is required for paths containing whitespace)
```

Copy new files, directories or remote file URLs from `<src>` and adds them to the filesystem of the image at the path `<dest>`.

- `<dest>` is an absolute path, or a path relative to `WORKDIR`
- `<src>` path must be inside the context of the build, cannot `ADD ../something/something`
- If `<src>` is a directory, the entire contents of the directory are copied, including filesystem metadata.
- If multiple `<src>` resources are specified, either directly or due to the use of a wildcard, then `<dest>` must be a directory, and it must end with a slash `/`.

### COPY
```dockerfile
COPY <src>... <dest>
COPY ["<src>",... "<dest>"] #(this form is required for paths containing whitespace)
```

> Same as `ADD`, but without the tar and remote URL handling.

### ENTRYPOINT

```dockerfile
ENTRYPOINT ["executable", "param1", "param2"] #(exec form, preferred)
ENTRYPOINT command param1 param2 #(shell form)
```

allows you to configure a container that will run as an executable.

- Command line arguments to `docker run <image>` will be appended after all elements in an `exec` form `ENTRYPOINT`, and will **override** all elements specified using `CMD`.
- only the last `ENTRYPOINT` instruction in the `Dockerfile` will have an effect.

[论docker中 CMD 与 ENTRYPOINT 的区别](http://cloud.51cto.com/art/201411/457338.htm)

### Volume

[深入理解Docker Volume](http://dockone.io/article/128)

### USER
```dockerfile
USER <user>[:<group>] or
USER <UID>[:<GID>]
```
sets the user name (or UID) and optionally the user group (or GID) to use when running the image and for any RUN, CMD and ENTRYPOINT instructions that follow it in the Dockerfile.
- defalut as root group

### WORKDIR
```dockerfile
WORKDIR /path/to/workdir
```
sets the working directory for any RUN, CMD, ENTRYPOINT, COPY and ADD instructions that follow it in the Dockerfile

- `WORKDIR` can resolve environment variables previously set using `ENV`

### ARG
```dockerfile
ARG <name>[=<default value>]
```

define a variable that users can pass at build-time to the builder with the `docker build` command using the `--build-arg <varname>=<value>` flag