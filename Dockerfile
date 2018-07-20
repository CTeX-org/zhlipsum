FROM ubuntu:bionic

LABEL Description="Dockerized MiKTeX, Ubuntu 18.04" Vendor="Xiangdong Zeng" Version="0.1"

RUN apt-get update \
  && apt-get install gnupg ca-certificates -y \
  && apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys D6BC243565B2087BC3F897C9277A7293F59E4889 \
  && echo "deb http://miktex.org/download/ubuntu bionic universe" | tee /etc/apt/sources.list.d/miktex.list

RUN apt-get update \
  && apt-get install miktex -y \
  && miktexsetup finish
