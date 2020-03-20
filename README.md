# In-memory store

To build a mirage unikernel using the direct network stack:

1. Configure
    - On non-osx unix systems:

```shell
$ mirage configure -t unix --dhcp true --net=direct
```
    - If you are on MacOS use the dedicated macosx/vmnet stack:

```shell
$ mirage configure -t macosx --dhcp true --net=direct
```

2. Install dependencies and build
```shell
$ make depend
$ make
```

3. Run as root

```
./main.native
```