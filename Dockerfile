FROM debian:testing
# FROM shimaore/debian:2.0.14
MAINTAINER Stéphane Alnet <stephane@shimaore.net>

# Inspired by and based on:
# https://github.com/lfuelling/android-sdk-docker
# https://github.com/Kallikrein/dockerfiles/blob/master/cordova/Dockerfile
# https://github.com/oren/docker-cordova/blob/master/Dockerfile

# Install Java.
RUN \
  apt-get update && \
  apt-get install -y --no-install-recommends \
    openjdk-8-jdk-headless \
    lib32stdc++6 lib32z1 \
    ca-certificates \
    curl \
    git \
    make \
    unzip \
  && \
  rm -rf /var/lib/apt/lists/*

ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64

# Install Android SDK.
RUN \
  curl -O https://dl.google.com/android/repository/tools_r25.2.3-linux.zip && \
  unzip -d /usr/local/android-sdk-linux tools_r25.2.3-linux.zip && \
  rm tools_r25.2.3-linux.zip
ENV ANDROID_HOME /usr/local/android-sdk-linux
ENV PATH $PATH:$ANDROID_HOME/tools

RUN \
  (yes | /usr/local/android-sdk-linux/tools/bin/sdkmanager --update) && \
  (yes | /usr/local/android-sdk-linux/tools/bin/sdkmanager 'platforms;android-25')

# /usr/local/android-sdk-linux/tools/bin/sdkmanager --list

# Install Node.js.
RUN \
  git clone https://github.com/tj/n.git n.git && \
  cd n.git && \
  make install && \
  cd .. && \
  rm -rf n.git && \
  n 7.4.0

# Install Cordova.
RUN \
  npm install -g cordova
