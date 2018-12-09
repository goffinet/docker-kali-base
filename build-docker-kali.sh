#!/bin/bash
reponame="goffinet"
sudo apt-get install debootstrap
curl "http://git.kali.org/gitweb/?p=packages/debootstrap.git;a=blob_plain;f=scripts/kali;hb=refs/heads/kali/master" > kali-debootstrap &&\
sudo debootstrap kali-rolling ./kali-root http://http.kali.org/kali ./kali-debootstrap &&\
sudo tar -C kali-root -c . | sudo docker import - $reponame/kali-base:latest &&\
sudo rm -rf ./kali-root &&\
echo "Build OK" || echo "Build failed!"
