#!/bin/bash

# Retrieve the list of image versions which are not the current installed and do the cleanup
for v in $(dpkg --list 'linux-image*' | awk '{ if ($1=="ii") print $2}'|grep -v `uname -r` | grep -v 'extra' | grep -v 'linux-image-generic' | sed 's/-generic//g' | sed 's/.*image-//g'); do
  rm -rf /boot/*-$v-*
  apt-get -y purge linux-image-$v-generic
done;

apt-get -f install

apt-get autoremove
