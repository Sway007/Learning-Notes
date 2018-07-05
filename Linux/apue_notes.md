# Chap 3. File I/O

### 1. File descriptor  

> UNIX System shells associate file descriptor 0 with the standard input of a process, file descriptor 1 with the standard output, and file descriptor 2 with the standard error.

`STDIN_FILENO/0`, `STDOUT_FILENO/1`, `STDERR_FILENO/2`

### 2. `open` and `openat` Functions

```C
#include <fcntl.h>
int open(const char *path, int oflag, ... /* mode_t mode */ );
int openat(int fd, const char *path, int oflag, ... /* mode_t mode */ );
```

`oflag`:  
> 1. `O_CREAT`   
> Create the file if it doesn’t exist. This option requires a third argument to the open function (a fourth argument to the openat function) — the mode, which specifies the access permission bits of the new file.
> 2. `O_TRUNC`  
> If the file exists and if it is successfully opened for either write-only or read–write, truncate its length to 0.

Quotes
1. > `The file descriptor returned by open and openat is guaranteed to be the lowest- numbered unused descriptor.`  
2. > `The openat function is one of a class of functions added to the latest version of POSIX.1 to address two problems. First, it gives threads a way to use relative pathnames to open files in directories other than the current working directory.`

### 3. `creat` Fuction
```c
#include <fcntl.h>
int creat(const char *path, mode_t mode);
```

1. This fuction is equivalent to
    ```c 
    open(path, O_WRONLY | O_CREAT | O_TRUNC, mode);
    ```

2. When a process terminates, all of its open files are closed automatically by the kernel.

### 4. `lseek` Function
```c
#include <unistd.h>
off_t lseek(int fd, off_t offset, int whence);

// explictly set an opened file's offset
```
1. `whence` could be `SEEK_SET`, `SEEK_CUR`, `SEEK_END`
2. The file’s offset can be greater than the file’s current size, in which case the next write to the file will extend the file. _<red>This is referred to as creating a hole in a file and is allowed. Any bytes in a file that have not been written are read back as 0.</red>_

### 5. `read` Function
```c
#include <unistd.h>
ssize_t read(int fd, void *buf, size_t nbytes);

// Returns: number of bytes read, 0 if end of file, −1 on error
```
 1. several cases in which the number of bytes actually read is less than the amount requested
    > 1. When reading from a regular file, if the end of file is reached before the requested number of bytes has been read. For example, if 30 bytes remain until the end of file and we try to read 100 bytes, read returns 30. The next time we call read, it will return 0 (end of file).
    > 2. _more cases can be found in apue page 37._

 2. The read operation starts at the file’s current offset. Before a successful return, the offset is incremented by the number of bytes actually read.

### 6. `write` Function
```c
#include <unistd.h>
ssize_t write(int fd, const void *buf, size_t nbytes);

// Returns: number of bytes written if OK, −1 on error
```

> For a regular file, the write operation starts at the file’s current offset. If the O_APPEND option was specified when the file was opened, the file’s offset is set to the current end of file before each write operation. After a successful write, the file’s offset is incremented by the number of bytes actually written.

### 7. File Sharing

> Note the difference in scope between the file descriptor flags and the file status flags. The former apply only to a single descriptor in a single process, whereas the latter apply to all descriptors in any process that point to the given file table entry.

### 8. Atomic Operations
```c
#include <unistd.h>
ssize_t pread(int fd, void *buf, size_t nbytes, off_t offset);
//Returns: number of bytes read, 0 if end of file, −1 on error

ssize_t pwrite(int fd, const void *buf, size_t nbytes, off_t offset);
// Returns: number of bytes written if OK, −1 on error
```
 > equivalent to calling lseek followed by a call to read, with the following exceptions:  
> - There is no way to interrupt the two operations that occur when we call pread.
> - The current file offset is not updated.

### 9. `sync`, `fsync` and `fdatasync` Function
```c
#include <unistd.h> 
int fsync(int fd);
int fdatasync(int fd);
void sync(void);
// Returns: 0 if OK, −1 on error
```

When write data to a file, the data is normally copied by the kernel into one of its buffers and **_queued for writing_** to disk at some later time.
> - The `sync` function simply queues all the modified block buffers for writing and returns; _it does not wait for the disk writes to take place_.
> > The function sync is normally called periodically (usually every 30 seconds) from a system daemon, often called update. This guarantees regular flushing of the kernel’s block buffers.
> - The function `fsync` refers only to a single file, specified by the file descriptor fd, and _waits for the disk writes to complete before returning_.
> - The `fdatasync` function is similar to fsync, but it affects only the data portions of a file. With fsync, the file’s attributes are also updated synchronously.

### 10. `fcntl` Function

change the properties of a file that is _already open_.
```c
#include <fcntl.h>
int fcntl(int fd, int cmd, ... /* int arg */ );

// Returns: depends on cmd if OK (see following), −1 on error 
```

the cmd values:
> - `F_GETFD`
> - `F_SETFD`
> > get/set the file *descriptor flags* for fd
> - `F_GETFL`
> - `F_SETFL`
> > set/get the file status flags for fd
> > the file status flag is explained as
> > > <center><img src='imgs_apue/file_status_flags.png'></center>
> - `F_GETOWN`
> - `F_SETOWN`
> > set/get the process ID or process group ID currently receiving the SIGIO and SIGURG signals

# Chap 4. File and Directories

### file stat
> <img src='../img/file_stat.png'>

### file permission:  
> <img src='../img/file_permission.png'>

### 1. `access` and `faccessat`

> the kernel performs its access tests based on the `effective` user and group IDs.

```c
#include <unistd.h>
int access(const char *pathname, int mode);
int faccessat(int fd, const char *pathname, int mode, int flag);
// Both return: 0 if OK, −1 on error
```
> The access and faccessat functions base their tests on the real user and group IDs

### 2. `umask`
```c
#include <sys/stat.h>
mode_t umask(mode_t cmask);
// Returns: previous file mode creation mask
```

- example
```c
#include "apue.h"
#include <fcntl.h>
#define RWRWRW (S_IRUSR|S_IWUSR|S_IRGRP|S_IWGRP|S_IROTH|S_IWOTH)

int main(void)
{
    umask(0);
    if (creat("foo", RWRWRW) < 0)
        err_sys("creat error for foo");
    umask(S_IRGRP | S_IWGRP | S_IROTH | S_IWOTH);
    if (creat("bar", RWRWRW) < 0)
        err_sys("creat error for bar");
    exit(0);
}
/*
the final file permission is formatted by the bit operation(RWRWRW - umask)
*/
```

- shell command `umask`

    1. `umask`:   show current shell file mode creation mask
    2. `umask mode`: set current shell file mode creation mask
    3. `umask -S`: show current shell file mode creation mask in `symbolic form`

### 3. `chmod`, `fchmod` and `fchmodat`
```c
#include <sys/stat.h>
int chmod(const char *pathname, mode_t mode);
int fchmod(int fd, mode_t mode);
int fchmodat(int fd, const char *pathname, mode_t mode, int flag);
```

- To change the permission bits of a file, the effective user ID of the process must be equal to the owner ID of the file, or the process must have superuser permissions.
- The mode is specified as the bitwise OR of the constants shown in figure:

    <img src='../img/mode.png'>

### 4. File Truncation

```c
#include <unistd.h>
int truncate(const char *pathname, off_t length); 
int ftruncate(int fd, off_t length);

```
- if the previous size was less than length, the file size will increase and the data between the old end of file and the new end of file will read as 0 (i.e., a hole is probably created in the file).


*TODO* not understood!


### 11. `ioctl` Function

```c
#include <unistd.h>  /* System V */
#include <sys/ioctl.h>  /* BSD and Linux */

int ioctl(int fd, int request, ...);
```


### 12. File System

```c
#include <unistd.h>

int link(const char *existingpath, const char *newpath);
int linkat(int efd, const char *existingpath, int nfd, const char *newpath, int flag);

int unlink(const char *pathname);
int unlinkat(int fd, const char *pathname, int flag);
```

1. every file is identified by _inode number_

2. hard link

    has the same inode numebr

3. symbolic link

    the link file's content is the linked file's mame(path)

    <img src='../img/file_sys_1.png'>
    <img src='../img/file_sys_2.png'>

4. rename a file

    add a new dirctory entry that points to the existing inode (namely have the same inode number) and then _unlink_ the old directory entry.

5. delet a file

    as long as some process has the file open, its contents will not be deleted. When a file is closed, the kernel first checks the count of the number of processes that have the file open. If this count has reached 0, the kernel then checks the link count; if it is 0, the file’s contents are deleted.

    - process creates a file using either open or creat and then immediately calls unlink. The file is not deleted, however, because it is still open. Only when the process either closes the file or terminates, which causes the kernel to close all its open files, is the file deleted.
    - We can also unlink a file or a directory with the `remove` function. For a file, remove is identical to unlink. For a directory, remove is identical to `rmdir`.

    ```c
    #include <stdio.h>
    int remove(const char *pathname);
    ```

<<<<<<< HEAD
=======
# Chap 5. Standard I/O Library

- When we open or create a file with the standard I/O library, we say that we have associated a stream with the file.

- the standard I/O library does not buffer the characters
- for the concept of `FILE` structure pls refer to Page 144

- ISO C I/O characteristics:
    - Stantard input and output are fully buffered if and only if they do not refer to an interactive device.
    - Standard error is never fully buffered.

### Buffer
```c
#include <stdio.h>
void setbuf(FILE *restrict fp, char *restrict buf );
int setvbuf(FILE *restrict fp, char *restrict buf, int mode,
size_t size);
```

- to disable buffering, set `buf` to `NULL`.
- the size of `buf` in function `setbuf` must be `BUFSIZE`, a constant defined in `<stdio.h>`.
- `setvbuf`: specify which type of buffering with the `mode` argument:
    - `_IOFBF` fully buffered
    - `_IOLBF` line bufferd
    - `_IONBF` unbuffered
- if we specify buffer mode as fully buffered or line buffered, and the `buf` is `NULL`, the standard I/O library will automatically allocate its own buffer of the appropriate size for the stream.

    <img src='../img/setvbuf_default.png'>

- force a stream to be flushed

    ```c
    #include <stdio.h>
    int fflush(FILE *fp);
    ```
    if `fp` is NULL, `fflush` causes all output streams to be flushed.

- open a stream

    ```c
    #include <stdio.h>
    FILE *fopen(const char *restrict pathname, const char *restrict type);
    FILE *freopen(const char *restrict pathname, const char *restrict type,
    FILE *restrict fp);
    FILE *fdopen(int fd, const char *type);
    ```

    - By default, the stream that is opened is fully buffered, unless it refers to a terminal device, in which case it is line buffered.
    - close an opened stream

        ```c
        #include <stdio.h>
        int fclose(FILE *fp);
        ```
        Any buffered output data is flushed before the file is closed. Any input data that may be buffered is discarded.

    - input functions

        ```c
        #include <stdio.h>
        int getc(FILE *fp);
        int fgetc(FILE *fp);
        int getchar(void);
        ```
        1. `getchar` is equivalent to getc(stdin).
        2. These three functions return the next character as an unsigned char converted to an int.

    - check error occurred or the end of file has been encountered.

        ```c
        #include <stdio.h>
        int ferror(FILE *fp);
        int feof(FILE *fp);
        // Both return: nonzero (true) if condition is true, 0 (false) otherwise
        void clearerr(FILE *fp);
        ```
        two flags are maintained for each stream in the `FILE` object:
        - an error flag
        - an end-of-file flag  
        both flag are cleared by calling `clearerr`
        
    - output functions

        ```c
        #include <stdio.h>
        int putc(int c, FILE *fp);
        int fputc(int c, FILE *fp);
        int putchar(int c);
        ```

- Binary I/O

    ```c
    #include <stdio.h>
    size_t fread(void *restrict ptr, size_t size, size_t nobj, FILE *restrict fp);

    size_t fwrite(const void *restrict ptr, size_t size, size_t nobj, FILE *restrict fp);
    // Both return: number of objects read or written
    ```

- postion a stream

    ```c
    #include <stdio.h>
    long ftell(FILE *fp);
    // Returns: current file position indicator if OK, −1L on error
    int fseek(FILE *fp, long offset, int whence);
    // Returns: 0 if OK, −1 on error
    void rewind(FILE *fp);
    ```
    - for a binary file, postion indicator is measured in bytes from the beginning of the file

- Formatted I/O

    ```c
    #include <stdio.h>
    int printf(const char *restrict format, ...);
    int fprintf(FILE *restrict fp, const char *restrict format, ...);
    int dprintf(int fd, const char *restrict format, ...);
    // All three return: number of characters output if OK, negative value if output error
    int sprintf(char *restrict buf, const char *restrict format, ...);
    // Returns: number of characters stored in array if OK, negative value if encoding error
    int snprintf(char *restrict buf, size_t n, const char *restrict format, ...);
    // Returns: number of characters that would have been stored in array if buffer was large enough, negative value if encoding error
    ```

    - `printf`: write to the standard output
    - `fprintf`: write to the specified stream
    - `dprintf`: write to the specified file descriptor
    - `sprintf`: palce the formatted characters in the array `buf`, and automatically append a null byte at the end of the array.
    - `snprintf`: a more secure version of `sprintf`. truncate the characters if its length exceed the size of `buf`

    - conversion syntax

        `$[flags][fldwidth][precision][lenmodifier]convtype`

        check the details in Page. 160

> the standard I/O library ends up calling the I/O routines that described in Chapter 3. Each Stantard I/O stream has an associated file descriptor. Obtain the descriptor for a stream by calling `fileno`
-
    ```c
    #include <stdio.h>
    int fileno(FILE *fp);
    ```

- Temporary files and directories

    ```c
    #include <stdio.h>
    char *tmpnam(char *ptr);

    FILE *tmpfile(void);
    ```
    - `tmpnam` create a tmp filename which does not match any existing file's name.

    - `tmpfile` creates a temporary binary file (type wb+) that is automatically removed when it is closed or on program termination.
    
    ```c
    #include <stdlib.h>
    char *mkdtemp(char *template);
    int mkstemp(char *template);
    ```
    - Unlike `tmpfile`, the temporary file created by `mkstemp` is not removed
    automatically for us.

- Memory Streams

    Memory streams have no underlying files, although they are accessed with `FILE` pointers.
    - create memory stream
        ```c
        #include <stdio.h>
        FILE *fmemopen(void *restrict buf, size_t size, const char *restrict type);
        ```

        if the `buf` is null, then the `fmemopen` allocates a buffer of `size` bytes.

    - whenever a memory stream is opened for append, the current file position is set to the first null byte in the buffer
    - The size of the stream’s contents is determined by how much we write to it.
        > see programe Figure 5.15

# Chap 6. System Data Files and Information

## Password File

- file path: `/etc/passwd`
- place holder for password
    - second
- name of the executable program to be used as the login shell for user
    - last
    - `/bin/false`, `/bin/true`, `/bin/nologin`, `/dev/null` used to prevent a particular user from logging into a system
- `nobody` user can be used to allow people login with no privileges.

```c
#include <pwd.h>
struct passwd *getpwuid(uid_t uid);
struct passwd *getpwnam(const char *name);
```
> return a pointer to a passwd structure that the functions fill in. the returned structure is usually a static variable within the function.

## Group File

- file path: `/etc/group`
- group structure

    <img src='../img/group_structure.png'>

    ```c
    #include <grp.h>
    struct group *getgrgid(gid_t gid);
    struct group *getgrnam(const char *name);
    ```
    ```c
    #include <unistd.h>
    int getgroups(int gidsetsize, gid_t grouplist[]);
    // Returns: number of supplementary group IDs if OK, −1 on error

    #include <grp.h> /* on Linux */
    #include <unistd.h> /* on FreeBSD, Mac OS X, and Solaris */
    int setgroups(int ngroups, const gid_t grouplist[]);

    #include <grp.h> /* on Linux and Solaris */
    #include <unistd.h> /* on FreeBSD and Mac OS X */
    int initgroups(const char *username, gid_t basegid);
    ```
    - `getgroups`: get all the groups which current process uidz belongs to 
    - system data files and respectively set/get functions

        <img src='../img/datafiles.png'>

## Login Accounting

> Two data files provided with most UNIX systems are the **_utmp_** file, which keeps track of all the users currently logged in, and the **_wtmp_** file, which keeps track of all logins and logouts.
- file path: `/var/log/wtmp` and `/var/run/utmp`

## System Identification

```c
#include <sys/utsname.h>
int uname(struct utsname *name);
```

```c
struct utsname {
    char sysname[]; /* name of the operating system */
    char nodename[]; /* name of this node */
    char releasep[]; /* current release of operating system */
    char version[];
    char machine[]; /* name of hardware type */
};
```
```c
#include <unistd.h>
int gethostname(char *name, int namelen);
```

## Time and Date Routines

# TODO Page. 189
>>>>>>> 7e8910a6dd2419931a92634f3484150339b2075c