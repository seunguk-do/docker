# docker - repository for dockerfiles and scripts

## Build Image
./scripts/build_image.sh [image_name] [version]
```
./scripts/build_image.sh cuda 11.8.0-runtime-ubuntu22.04
```
- [image_name] should be selected from the directory "dockerfiles"
- [version] should be selected among the versions available in the base image

## Run Container
./scripts/run_container.sh [container_name] [image] [version] [code_dir] [data_dir] [cpuset]
```
./scripts/run_container.sh seunguk_cuda cuda 11.8.0-runtime-ubuntu22.04 ~/Codes ~/Data 0-19

```
