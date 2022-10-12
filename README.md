# CUDA - repository for dockerfiles and scripts

## Build Image
```
./scripts/build_image [image_name] [version]
```
- Image_name should be selected from the directory "dockerfiles"
- Version should be selected among the versions available in the base image

## Run Container
```
./scripts/run_container [container_name] [image] [version] [code_dir] [data_dir]
