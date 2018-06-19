# How to format and mount drive

> ### commonds: 1._**fdisk**_ 2._**df -h**_ 3._**mount**_ 4._**mkfs.ext4**_  _etc_. .



## Fotmat

    mkfs.ext4 {$you_device}

----------------------------

## For drive smaller than 2 TB


### 1. Find our hard drive using:
    
    fdisk -l

get our device name: `/dev/sdb`

### 2. Delete all existed partitions (if exist):

    fdisk {$your_device}

then print _**m**_ for _hlep menu_ .
Just follow the **help menu** steps

-------------------------------

## For drive larger than 2 TB

    parted {$your_device}
    mklabel gpt
    mkpart primary 0 50%    # make partition
    list
    quit     # if everything looks good
    
---------------------------------
 Anyway, if you want to do something to your drive such as formating, changing disk format, partition, etc., remember using command `fdisk` or `parted` .

> [How to install a new drive in Linux larger than 2TB with proper alignment](https://duntuk.com/how-install-new-drive-linux-larger-2tb-proper-alignment)

> [ Linux下快速分区格式化大于2T大容量存储](http://300second.blog.51cto.com/7582/1068203) 

> [Linux 分区、格式化3T大容量存储分区](https://my.oschina.net/lionel45/blog/611403)