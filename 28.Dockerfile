FROM openjdk:8-slim

MAINTAINER Aditya Rahman <mail@aditaja.my.id>

ARG SDK_URL="https://dl.google.com/android/repository/commandlinetools-linux-6609375_latest.zip"
ARG FLUTTER_URL="https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_2.2.3-stable.tar.xz"

ENV PATH=$PATH:/opt/android-sdk-linux/cmdline-tools/tools/bin:/opt/flutter/bin
ENV ANDROID_SDK_ROOT=/opt/android-sdk-linux

RUN apt update -y \
  && apt install -y curl git unzip xz-utils  \
  && mkdir -p /opt/android-sdk-linux \
  && curl $SDK_URL -o /tmp/commandlinetools.zip \
  && unzip /tmp/commandlinetools.zip -d /opt/android-sdk-linux/cmdline-tools \
  && yes | sdkmanager \
    "platform-tools" \
    "platforms;android-28" \
    "platforms;android-29" \
    "platforms;android-30" \
    `sdkmanager --list | grep build-tools | tail -1 | awk '{print $1}'` \
  && yes | sdkmanager --licenses \
  && cd /opt \
  && curl -O $FLUTTER_URL \
  && export FLUTTER_TAR_FILE=$(find -name flutter_linux*.tar.xz) \
  && tar xf $FLUTTER_TAR_FILE \
  && rm -v $FLUTTER_TAR_FILE \
  && flutter doctor
