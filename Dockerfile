FROM openjdk:8-slim

ARG SDK_URL="https://dl.google.com/android/repository/commandlinetools-linux-6609375_latest.zip"
ENV PATH=$PATH:/opt/android-sdk-linux/cmdline-tools/tools/bin:/opt/flutter/bin
ENV ANDROID_SDK_ROOT=/opt/android-sdk-linux

RUN apt update -y \
  && apt install -y curl git unzip \
  && mkdir -p /opt/android-sdk-linux \
  && curl $SDK_URL -o /tmp/commandlinetools.zip \
  && unzip /tmp/commandlinetools.zip -d /opt/android-sdk-linux/cmdline-tools \
  && yes | sdkmanager "platform-tools" "platforms;android-30" "build-tools;30.0.2" \
  && yes | sdkmanager --licenses \
  && cd /opt \
  && git clone https://github.com/flutter/flutter.git \
  && flutter doctor
