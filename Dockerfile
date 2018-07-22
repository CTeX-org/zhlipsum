# See https://github.com/MiKTeX/docker-miktex/blob/master/Dockerfile
# and https://github.com/nanmu42/TeXPackageTestBench/blob/master/Dockerfile

FROM ubuntu:bionic

LABEL Description="Dockerized MiKTeX, Ubuntu 18.04" Vendor="Xiangdong Zeng" Version="0.1"

RUN apt-get update \
  && apt-get install --yes gnupg ca-certificates \
  && apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys D6BC243565B2087BC3F897C9277A7293F59E4889

# For USA
# https://mirrors.rit.edu/CTAN/...
# deb https://ftp.yz.yamagata-u.ac.jp/pub/CTAN/systems/win32/miktex/setup/deb/ bionic universe
RUN echo "deb http://miktex.org/download/ubuntu bionic universe" | tee /etc/apt/sources.list.d/miktex.list \
  && apt-get update \
  && apt-get install --yes miktex

RUN initexmf --admin --force --mklinks
# Install packages (spaces are not allowed in mpm's file list)
# --repository=http://ftp.yz.yamagata-u.ac.jp/pub/CTAN/systems/win32/miktex/tm/packages/
RUN mpm --admin --verbose --install adobemapping,amsfonts,amsmath,caption,cjk,cjkpunct,cm,ctablestack,ctex,currfile,dvipdfmx,environ,etex,etoolbox,euenc,fancyhdr,fandol,filehook,fontspec,graphics,graphics-cfg,graphics-def,ifxetex,kantlipsum,knuth-lib,l3build,l3experimental,l3kernel,l3packages,lm,lm-math,ltxbase,lualatex-math,lualibs,luaotfload,luatex85,luatexbase,luatexja,metafont,mfware,miktex-luatex,miktex-tex,miktex-xetex,ms,oberdiek,preview,psnfss,tex-ini-files,tools,trimspaces,ucharcat,ulem,unicode-data,uplatex,varwidth,xcjk2uni,xcolor,xecjk,xkeyval,xunicode,zhmetrics,zhnumber
# Configure MiKTeX
RUN initexmf --admin --verbose --mkmaps
RUN initexmf --admin --verbose --update-fndb
# Diagnosis information
RUN initexmf --admin --report
RUN initexmf --admin --list-formats

RUN useradd -md /home/miktex miktex \
  && mkdir /home/miktex/work \
  && mkdir /home/miktex/.miktex
USER miktex
WORKDIR /home/miktex/work
