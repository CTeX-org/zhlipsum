FROM ubuntu:bionic

LABEL Description="Dockerized MiKTeX, Ubuntu 18.04" Vendor="Xiangdong Zeng" Version="0.1"

RUN apt-get update \
  && apt-get install gnupg ca-certificates -y \
  && apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys D6BC243565B2087BC3F897C9277A7293F59E4889 \
  && echo "deb http://miktex.org/download/ubuntu bionic universe" | tee /etc/apt/sources.list.d/miktex.list

RUN apt-get update \
  && apt-get install miktex -y \
  && miktexsetup finish \
# Install packages (spaces are not allowed in mpm's file list)
  && mpm --admin --verbose --install adobemapping,amsfonts,amsmath,caption,cjk,cjkpunct,cm,ctablestack,ctex,currfile,dvipdfmx,environ,etex,etoolbox,euenc,fancyhdr,fandol,filehook,fontspec,graphics,graphics-cfg,graphics-def,ifxetex,kantlipsum,knuth-lib,l3build,l3experimental,l3kernel,l3packages,lm,lm-math,ltxbase,lualatex-math,lualibs,luaotfload,luatex85,luatexbase,luatexja,metafont,mfware,miktex-luatex,miktex-tex,miktex-xetex,ms,oberdiek,preview,psnfss,tex-ini-files,tools,trimspaces,ucharcat,ulem,unicode-data,uplatex,varwidth,xcjk2uni,xcolor,xecjk,xkeyval,xunicode,zhmetrics,zhnumber \
# Configure MiKTeX
  && initexmf --admin --verbose --mkmaps \
  && initexmf --admin --verbose --update-fndb \
  && initexmf --admin --verbose --dump \
  && initexmf --admin --verbose --force --mklinks \
# Diagnosis information
  && initexmf --report \
  && initexmf --list-formats

RUN useradd -md /home/miktex miktex
  && mkdir /home/miktex/work
  && mkdir /home/miktex/.miktex
USER miktex
WORKDIR /home/miktex/work
