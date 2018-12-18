#!/usr/bin/env bash

# ==============================================

# Reference: https://dzone.com/articles/installing-openjdk-11-on-ubuntu-1804-for-real (Installing OpenJDK Manually)

if [ -f /vagrant/openjdk-11+28_linux-x64_bin.tar.gz ]
then
    echo "* Java downloaded already." 
else
  echo "* Downloading java..."
  wget -nc https://download.java.net/java/GA/jdk11/28/GPL/openjdk-11+28_linux-x64_bin.tar.gz -O /vagrant/openjdk-11+28_linux-x64_bin.tar.gz
fi

if [ -d /usr/lib/jvm ]
then
    echo "* Java already installed." 
else
  echo "* Installing java..."
  mkdir /usr/lib/jvm
  tar xfvz /vagrant/openjdk-11+28_linux-x64_bin.tar.gz --directory /usr/lib/jvm
fi

echo "* Adding java to path..."
echo "export JAVA_HOME=/usr/lib/jvm/jdk-11/" >> /home/vagrant/.bashrc
echo "export PATH=\$JAVA_HOME/bin:\$PATH" >> /home/vagrant/.bashrc

# ==============================================

# Don't need gradle this way, sprint-initializr brings it for us :)
#apt-get update
#apt-get install -y gradle

echo "* Getting 'make'..."
apt-get install make

# ==============================================

# Reference: https://redis.io/topics/quickstart

if [ -f /vagrant/redis-stable.tar.gz ]
then
    echo "* Redis downloaded already." 
else
  echo "* Downloading redis..."
  wget -nc http://download.redis.io/redis-stable.tar.gz -O /vagrant/redis-stable.tar.gz
fi

if [ -f /usr/local/bin/redis-server ]
then
    echo "* Redis already installed." 
else
  echo "* Installing redis..."
  tar xvzf /vagrant/redis-stable.tar.gz --directory /vagrant
  cd /vagrant/redis-stable
  make
  make install
fi

echo "* Starting redis..."
redis-server --daemonize yes

# ==============================================(3m40s)

# TODO: add cf-cli install

# TODO: add login config against single account

# TODO: add auto creation of developer-laptop space

# ==============================================(3m40s)

echo "* Adding auto-move to workspace for shells..."
echo "cd /vagrant" >> /home/vagrant/.bashrc