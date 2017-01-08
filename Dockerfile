# Needs:
# - Node.js for Cordova
# - Android SDK, which means JDK etc.
# - Gradle preinstalled
# So probably best place to start is https://github.com/lfuelling/android-sdk-docker
# because I know how to do the Node.js part.

FROM debian:testing
# FROM shimaore/debian:2.0.14
MAINTAINER Stéphane Alnet <stephane@shimaore.net>

# Based on
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

# Define commonly used JAVA_HOME variable
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64

# download and extract android sdk
RUN \
  curl -O https://dl.google.com/android/repository/tools_r25.2.3-linux.zip && \
  unzip -d /usr/local/android-sdk-linux tools_r25.2.3-linux.zip && \
  rm tools_r25.2.3-linux.zip
ENV ANDROID_HOME /usr/local/android-sdk-linux
ENV PATH $PATH:$ANDROID_HOME/tools

# update and accept licences
RUN \
  (yes | /usr/local/android-sdk-linux/tools/bin/sdkmanager --update) && \
  (yes | /usr/local/android-sdk-linux/tools/bin/sdkmanager 'platforms;android-25') && \
  /usr/local/android-sdk-linux/tools/bin/sdkmanager --list
#   --filter platform-tool,build-tools-22.0.1,android-22 \

ENV GRADLE_USER_HOME /src/gradle

RUN \
  git clone https://github.com/tj/n.git n.git && \
  cd n.git && \
  make install && \
  cd .. && \
  rm -rf n.git && \
  n 7.4.0

RUN \
  npm install -g cordova
