#!/bin/bash
sudo apt-get install debootstrap
# Fetch the latest Kali debootstrap script from git
curl "http://git.kali.org/gitweb/?p=packages/debootstrap.git;a=blob_plain;f=scripts/kali;hb=refs/heads/kali/master" > kali-debootstrap &&\
sudo debootstrap kali-rolling ./kali-root http://http.kali.org/kali ./kali-debootstrap &&\
sudo tar -C kali-root -c . | sudo docker import - goffinet/kali:latest &&\
sudo rm -rf ./kali-root &&\
TAG=$(sudo docker run -t -i goffinet/kali awk '{print $NF}' /etc/debian_version | sed 's/\r$//' ) &&\
echo "Tagging kali with $TAG" &&\
sudo docker tag goffinet/kali-base:latest goffinet/kali:$TAG &&\
echo "Build OK" || echo "Build failed!"
