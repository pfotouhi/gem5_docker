## gem5 in docker
### What is it?

This builds a docker image that contains ROCm and gem5. The intended use is to run various benchmarks on the APU model in gem5.

The container (currently) uses ROCm 1.6.3; This can be overridden when building the docker image. (Only tested 1.6.x, using 1.6.0 will result in a build failure)

### How to build/run?
[The dockerhub repo](https://cloud.docker.com/repository/registry-1.docker.io/kroarty/gem5) should contain a prebuilt image

From source:
```
docker build [--build-arg rocm_ver=<version>] -t <im_name> .
docker run [--name <container_name>] -it [-d] <im_name> [<command>]
```
If '-d' is specified, the container will run in the background \
If '\<command\>' isn't specified, the container will run a bash shell

### Building gem5 in the container

To keep filesize down, gem5 is not pre-built. So on the initial run of a container, gem5 needs to be built.

When attached to the container:
```
cd /gem5
scons -j$(nproc) build/GCN3_X86/gem5.opt --ignore-style
```
When running the container in the background:
`docker exec -w/gem5 <container_name> scons -j$(nproc) /sim/gem5/build/GCN3_X86/gem5.opt --ignore-style`

### Misc

* Why ROCm 1.6.3?

It's the most recent of the 1.6.x version that doesn't throw an error when running square (A test program). 1.6.4 does complete the square program, but the simulator crashes afterwards.
* Why can't we use ROCm 1.6.0?

It unpacks into a different directory structure than 1.6.1-1.6.4; This can be changed in the dockerfile, line 31. After ${rocm_ver}, add '/debian' and it will build

### ToDo
* Check dependencies, if any more are needed or if any can be removed
* Allow building with docker-compose
