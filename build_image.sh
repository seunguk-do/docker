#!/bin/bash

VERSION="12.1.1-cudnn8-ubuntu22.04"
docker build \
  -t seunguk/cuda:$VERSION \
  --build-arg USER_ID=$UID \
  ./cuda${VERSION}
