FROM debian:testing
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
ENV ANDROID_HOME /usr/local/android-sdk-linux
ENV ANDROID_ZIP tools_r25.2.3-linux.zip
RUN \
  curl -O https://dl.google.com/android/repository/$ANDROID_ZIP && \
  unzip -d $ANDROID_HOME $ANDROID_ZIP && \
  rm $ANDROID_ZIP
ENV PATH $PATH:$ANDROID_HOME/tools

RUN \
  (yes | /usr/local/android-sdk-linux/tools/bin/sdkmanager --update) && \
  (yes | /usr/local/android-sdk-linux/tools/bin/sdkmanager 'platforms;android-25')

# /usr/local/android-sdk-linux/tools/bin/sdkmanager --list

# Install Gradle.
ENV GRADLE_HOME /usr/local/gradle
ENV GRADLE_ZIP gradle-3.3-bin.zip
RUN \
  curl -O https://services.gradle.org/distributions/$GRADLE_ZIP && \
  unzip -d $GRADLE_HOME $GRADLE_ZIP && \
  rm $GRADLE_ZIP
ENV PATH $PATH:$GRADLE_HOME/tools

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
