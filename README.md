# AndroidSDK

Android SDK development environment Docker image

[![Docker Hub](https://img.shields.io/badge/Docker%20Hub-info-blue.svg)](https://hub.docker.com/r/thyrlian/android-sdk/)
[![Build Status](https://travis-ci.org/thyrlian/AndroidSDK.svg?branch=master)](https://travis-ci.org/thyrlian/AndroidSDK)
[![Android Dev Digest](https://img.shields.io/badge/AndroidDevDigest-%23127-green.svg)](https://www.androiddevdigest.com/digest-127/)
[![Android开发技术周报](https://img.shields.io/badge/Android%E5%BC%80%E5%8F%91%E6%8A%80%E6%9C%AF%E5%91%A8%E6%8A%A5-%23114-yellowgreen.svg)](http://www.androidweekly.cn/android-dev-weekly-issue-114/)

<img src="https://github.com/thyrlian/AndroidSDK/blob/master/images/logo.png?raw=true" width="200">

<a href="https://youtu.be/YwBAqMDYFCU"><img src="https://pbs.twimg.com/media/DODnbwmXkAAbXuM.jpg" alt="Conference Talk" width="600"></a>

## Goals

* It contains the complete Android SDK enviroment, is able to perform all regular Android jobs.
* Solves the problem of "*It works on my machine, but not on XXX machine*".
* Some tool (e.g. [Infer](https://github.com/facebook/infer)), which has complex dependencies might be in conflict with your local environment.  Installing the tool within a Docker container is the easiest and perfect solution.
* Directly being used as Android CI build enviroment.

## Philosophy

Provide only the barebone SDK (the latest official minimal package) gives you the most flexibility in tailoring your own SDK tools for your project.  You can maintain an external persistent SDK directory, and mount it to any container.  In this way, you don't have to waste time on downloading over and over again, meanwhile, without having any unnecessary package.

## Caveat

Run Android SDK update directly within the **Dockerfile** or inside the **container** would fail if the storage driver is `AUFS` (by default), it is due to some file operations (during updating) are not supported by this storage driver, but changing it to `Btrfs` would work.

What happens if the update fails?
```bash
ls $ANDROID_HOME/tools/
#=> empty, nothing is there
# tools such as: android, sdkmanager, emulator, lint and etc. are gone

android
#=> bash: android: command not found

sdkmanager
#=> bash: /opt/android-sdk/tools/bin/sdkmanager: No such file or directory
```

To know more about the storage driver:

* Check Docker's current storage driver option
```console
docker info | grep 'Storage Driver'
```

* Check which filesystems are supported by the running host kernel
```console
cat /proc/filesystems
```

To prevent this problem from happening, and you don't wanna bother dealing with storage driver.  The only solution is to mount an external SDK volume from host to container.  Then you are free to try any of below approaches.

* Update SDK in the usual way but directly inside container.
* Update SDK from host directory (**Remember**: the host machine must be the same target architecture as the container - `x86_64 Linux`).

If you by accident update SDK on a host machine which has a mismatch target architecture than the container, some binaries won't be executable in container any longer.

```bash
gradle <some_task>
#=> Error: java.util.concurrent.ExecutionException: java.lang.RuntimeException: AAPT process not ready to receive commands

$ANDROID_HOME/build-tools/x.x.x/aapt
#=> aapt: cannot execute binary file: Exec format error

adb
#=> adb: cannot execute binary file: Exec format error
```

## Getting Started

```bash
# build the image
# set the working directory to the project's root directory first
docker build -t android-sdk android-sdk
# or pull the image
docker pull thyrlian/android-sdk

# below commands assume that you've pulled the image

# copy the pre-downloaded SDK to the mounted 'sdk' directory
docker run -it --rm -v $(pwd)/sdk:/sdk thyrlian/android-sdk bash -c 'cp -a $ANDROID_HOME/. /sdk'

# go to the 'sdk' directory on the host, update the SDK
# ONLY IF the host machine is the same target architecture as the container
# JDK required on the host
sdk/tools/bin/sdkmanager --update
# or install specific packages
sdk/tools/bin/sdkmanager "build-tools;x.y.z" "platforms;android-x" ...

# mount the updated SDK to container again
# if the host SDK directory is mounted to more than one container
# to avoid multiple containers writing to the SDK directory at the same time
# you should mount the SDK volume in read-only mode
docker run -it -v $(pwd)/sdk:/opt/android-sdk:ro thyrlian/android-sdk /bin/bash

# you can mount without read-only option, only if you need to update SDK inside container
docker run -it -v $(pwd)/sdk:/opt/android-sdk thyrlian/android-sdk /bin/bash

# to keep and reuse Gradle cache
docker run -it -v $(pwd)/sdk:/opt/android-sdk -v $(pwd)/gradle_caches:/root/.gradle/caches thyrlian/android-sdk /bin/bash

# to stop and remove container
# when the image was pulled from a registry
docker stop $(docker ps -aqf "ancestor=thyrlian/android-sdk") &> /dev/null && docker rm $(docker ps -aqf "ancestor=thyrlian/android-sdk") &> /dev/null
# when the image was built locally
docker stop $(docker ps -aqf "ancestor=android-sdk") &> /dev/null && docker rm $(docker ps -aqf "ancestor=android-sdk") &> /dev/null
# more flexible way - doesn't matter where the image comes from
docker stop $(docker ps -a | grep 'android-sdk' | awk '{ print $1 }') &> /dev/null && docker rm $(docker ps -a | grep 'android-sdk' | awk '{ print $1 }') &> /dev/null
```

## SSH

It is also possible if you wanna connect to container via SSH.  There are three different approaches.

* Build an image on your own, with a built-in `authorized_keys`

```bash
# Put your `id_rsa.pub` under `android-sdk/authorized_keys` (as many as you want)

# Build an image
docker build -t android-sdk android-sdk

# Run a container
docker run -d -p 2222:22 -v $(pwd)/sdk:/opt/android-sdk:ro android-sdk
```

* Mount `authorized_keys` file from the host to a container

```bash
docker run -d -p 2222:22 -v $(pwd)/authorized_keys:/root/.ssh/authorized_keys thyrlian/android-sdk
```

* Copy a local `authorized_keys` file to a container

```bash
# Create a local `authorized_keys` file, which contains the content from your `id_rsa.pub`

# Run a container
docker run -d -p 2222:22 -v $(pwd)/sdk:/opt/android-sdk:ro thyrlian/android-sdk

# Copy the just created local authorized_keys file to the running container
docker cp $(pwd)/authorized_keys `docker ps -aqf "ancestor=thyrlian/android-sdk"`:/root/.ssh/authorized_keys

# Set the proper owner and group for authorized_keys file
docker exec -it `docker ps -aqf "ancestor=thyrlian/android-sdk"` bash -c 'chown root:root /root/.ssh/authorized_keys'
```

That's it!  Now it's up and running, you can ssh to it

```console
ssh root@<container_ip_address> -p 2222
```

And, in case you need, you can still attach to the running container (not via ssh) by

```console
docker exec -it <container_id> /bin/bash
```

<img src="https://github.com/thyrlian/AndroidSDK/blob/master/images/SSH.png?raw=true">

## VNC

Remote access to the container's desktop might be helpful if you plan to run emulator inside the container.

```bash
# pull the image with VNC support
docker pull thyrlian/android-sdk-vnc

# spin up a container
# with SSH
docker run -d -p 5901:5901 -p 2222:22 -v $(pwd)/sdk:/opt/android-sdk android-sdk-vnc
# or with interactive session
docker run -it -p 5901:5901 -v $(pwd)/sdk:/opt/android-sdk android-sdk-vnc /bin/bash
```

When the container is up and running, use your favorite VNC client to connect to it:

* `<container_ip_address>:5901`

* Password (with control): ***android***

* Password (view only): ***docker***

```bash
# setup and launch emulator inside the container
# create a new Android Virtual Device
echo "no" | avdmanager create avd -n test -k "system-images;android-25;google_apis;armeabi-v7a"
# launch emulator
emulator64-arm -avd test -noaudio -no-boot-anim -gpu offscreen
```

For more details, please refer to [Emulator section](https://github.com/thyrlian/AndroidSDK#emulator).

<img src="https://github.com/thyrlian/AndroidSDK/blob/master/images/vnc.png?raw=true">

## NFS

You can host the Android SDK in one host-independent place, and share it across different containers.  One solution is using NFS (Network File System).

To make the container consume the NFS, you can try either way below:
* Mount the NFS onto your host machine, then run container with volume option (`-v`).
* Use a Docker volume plugin, for instance [Convoy plugin](https://github.com/rancher/convoy).

And here are instructions for configuring a NFS server (on Ubuntu):

```bash
sudo apt-get update
sudo apt-get install -y nfs-kernel-server
sudo mkdir -p /var/nfs/android-sdk

# put the Android SDK under /var/nfs/android-sdk
# if you haven't got any, run below commands
sudo apt-get install -y wget zip
cd /var/nfs/android-sdk
sudo wget -q $(wget -q -O- 'https://developer.android.com/sdk' | grep -o "\"https://.*android.*tools.*linux.*\"" | sed "s/\"//g")
sudo unzip *tools*linux*.zip
sudo rm *tools*linux*.zip
sudo mkdir licenses
echo 8933bad161af4178b1185d1a37fbf41ea5269c55 | sudo tee licenses/android-sdk-license > /dev/null
echo 84831b9409646a918e30573bab4c9c91346d8abd | sudo tee licenses/android-sdk-preview-license > /dev/null
echo d975f751698a77b662f1254ddbeed3901e976f5a | sudo tee licenses/intel-android-extra-license > /dev/null

# configure and launch NFS service
sudo chown nobody:nogroup /var/nfs
echo "/var/nfs         *(rw,sync,no_subtree_check,no_root_squash)" | sudo tee --append /etc/exports > /dev/null
sudo exportfs -a
sudo service nfs-kernel-server start
```

## Gradle distributions mirror server

There is still a little room for optimization: recent distribution of Gradle is around 90MB, imagine different containers / build jobs have to perform downloading many times, and it has high influence upon your network bandwidth.  Setting up a local Gradle distributions mirror server would significantly boost your download speed.

Fortunately, you can easily build such a mirror server docker image on your own.

```bash
docker build -t gradle-server gradle-server
# by default it downloads the most recent 14 gradle distributions (excluding rc or milestone)
```

The download amount can be changed [here](https://github.com/thyrlian/AndroidSDK/blob/master/gradle-server/Dockerfile#L30).  Preferably, you should run the [download script](https://github.com/thyrlian/AndroidSDK/blob/master/gradle-server/gradle_downloader.sh) locally, and mount the download directory to the container.

```bash
gradle-server/gradle_downloader.sh [DOWNLOAD_DIRECTORY] [DOWNLOAD_AMOUNT]
docker run -d -p 80:80 -p 443:443 -v [DOWNLOAD_DIRECTORY]:/var/www/gradle.org/public_html/distributions gradle-server
```

```bash
# copy the SSL certificate from gradle server container to host machine
docker cp `docker ps -aqf "ancestor=gradle-server"`:/etc/apache2/ssl/apache.crt apache.crt
# copy the SSL certificate from host machine to AndroidSDK container
docker cp apache.crt `docker ps -aqf "ancestor=thyrlian/android-sdk"`:/home/apache.crt
# add self-signed SSL certificate to Java keystore
docker exec -it `docker ps -aqf "ancestor=thyrlian/android-sdk"` bash -c '$JAVA_HOME/bin/keytool -import -trustcacerts -file /home/apache.crt -keystore $JAVA_HOME/jre/lib/security/cacerts -storepass changeit -noprompt'
# map gradle services domain to your local IP
docker exec -it `docker ps -aqf "ancestor=thyrlian/android-sdk"` bash -c 'echo "[YOUR_HOST_IP_ADDRESS_FOR_GRADLE_CONTAINER] services.gradle.org" >> /etc/hosts'
```

Starting from now on, gradle wrapper will download gradle distributions from your local mirror server, lightning fast!  The downloaded distribution will be uncompressed to `/root/.gradle/wrapper/dists`.

If you don't want to bother with SSL certificate, you can simply change the `distributionUrl` inside `[YOUR_PROJECT]/gradle/wrapper/gradle-wrapper.properties` from `https` to `http`.

## Emulator

ARM emulator is host machine independent, can run anywhere - Linux, macOS, VM and etc.  While the performance is a bit poor.  On the contrary, x86 emulator requires KVM, which means only runnable on Linux.

According to [Google's documentation](https://developer.android.com/studio/run/emulator-acceleration.html#accel-vm):

> **VM acceleration restrictions**

> Note the following restrictions of VM acceleration:

> * You can't run a VM-accelerated emulator inside another VM, such as a VM hosted by VirtualBox, VMWare, or Docker. You must run the emulator directly on your system hardware.

> * You can't run software that uses another virtualization technology at the same time that you run the accelerated emulator. For example, VirtualBox, VMWare, and Docker currently use a different virtualization technology, so you can't run them at the same time as the accelerated emulator.

### Preconditions on the host machine (for x86 emulator)

Read [How to Start Intel Hardware-assisted Virtualization (hypervisor) on Linux](https://software.intel.com/en-us/blogs/2012/03/12/how-to-start-intel-hardware-assisted-virtualization-hypervisor-on-linux-to-speed-up-intel-android-x86-emulator) for more details.

Read [KVM Installation](https://help.ubuntu.com/community/KVM/Installation) if you haven't got KVM installed on the host yet.

* Check the capability of running KVM
```bash
egrep -c '(vmx|svm)' /proc/cpuinfo
# or
egrep -c ' lm ' /proc/cpuinfo
# when output > 0 it means the host CPU supports hardware virtualization.

sudo kvm-ok
# seeing below info means you can run your virtual machine faster with the KVM extensions
INFO: /dev/kvm exists
KVM acceleration can be used
```

* Load KVM module on the host
```console
modprobe kvm_intel
```

* Check if KVM module is successfully loaded
```console
lsmod | grep kvm
```

### How to run emulator

* Check available emulator system images from remote SDK repository (on the host machine)
```console
sdkmanager --list --verbose
```

* Download emulator system image(s) (on the host machine)
```bash
sdkmanager "system_image_1" "system_image_2"
# e.g.:
# system-images;android-24;android-tv;x86
# system-images;android-24;default;arm64-v8a
# system-images;android-24;default;armeabi-v7a
# system-images;android-24;default;x86
# system-images;android-24;default;x86_64
# system-images;android-24;google_apis;arm64-v8a
# system-images;android-24;google_apis;armeabi-v7a
# system-images;android-24;google_apis;x86
# system-images;android-24;google_apis;x86_64
# system-images;android-24;google_apis_playstore;x86
```

* Run Docker container in privileged mode (not necessary for ARM emulator)
```bash
# required by KVM
docker run -it --privileged -v $(pwd)/sdk:/opt/android-sdk:ro thyrlian/android-sdk /bin/bash
```

* Check acceleration ability (not necessary for ARM emulator)
```bash
emulator -accel-check

# when succeeds
accel:
0
KVM (version 12) is installed and usable.
accel

# when fails (probably due to unprivileged mode)
accel:
8
/dev/kvm is not found: VT disabled in BIOS or KVM kernel module not loaded
accel
```

* Create a new Android Virtual Device
```bash
echo "no" | avdmanager create avd -n <name> -k <sdk_id>
# e.g.:
echo "no" | avdmanager create avd -n test -k "system-images;android-24;default;armeabi-v7a"
```

* List existing Android Virtual Devices
```bash
avdmanager list avd
# ==================================================
Available Android Virtual Devices:
    Name: test
    Path: /root/.android/avd/test.avd
  Target:
          Based on: Android 7.0 (Nougat) Tag/ABI: default/armeabi-v7a
# ==================================================

# or

emulator -list-avds
# 32-bit Linux Android emulator binaries are DEPRECATED
# ==================================================
test
# ==================================================
```

* Launch emulator in background
```bash
# use different command per architecture
emulator64-arm -avd <virtual_device_name> -noaudio -no-boot-anim -no-window -accel on &

# or
emulator64-mips -avd <virtual_device_name> -noaudio -no-boot-anim -no-window -accel on &

# or
emulator64-x86 -avd <virtual_device_name> -noaudio -no-boot-anim -no-window -accel on &

# if the container is not running in privileged mode, you should see below errors:
#=> emulator: ERROR: x86_64 emulation currently requires hardware acceleration!
#=> Please ensure KVM is properly installed and usable.
#=> CPU acceleration status: /dev/kvm is not found: VT disabled in BIOS or KVM kernel module not loaded
# or it's running on top of a VM
#=> CPU acceleration status: KVM requires a CPU that supports vmx or svm
```

* Check the virtual device status
```bash
adb devices
# ==================================================
List of devices attached
emulator-5554	offline
# "offline" means it's still booting up
# ==================================================

# ==================================================
List of devices attached
emulator-5554	device
# "device" means it's ready to be used
# ==================================================
```

Now you can for instance run UI tests on the emulator (just remember, the performance is POOR):
```console
<your_android_project>/gradlew connectedAndroidTest
```

### Access the emulator from outside

Default adb server port: `5037`

```bash
# spin up a container
# with SSH
docker run -d -p 5037:5037 -p 2222:22 -v $(pwd)/sdk:/opt/android-sdk android-sdk-vnc
# or with interactive session
docker run -it -p 5037:5037 -v $(pwd)/sdk:/opt/android-sdk android-sdk-vnc /bin/bash

# launch emulator inside the container...
```

Outside the container:

```bash
adb connect <container_ip_address>:5037
adb devices
#=> List of devices attached
#=> emulator-5554	device
```

Make sure that your **adb client** talks to the **adb server** inside the container, but not your local one.

## Android Device

You can give a container access to host's USB Android devices.
```console
# on Linux
docker run -it --privileged -v /dev/bus/usb:/dev/bus/usb -v $(pwd)/sdk:/opt/android-sdk thyrlian/android-sdk /bin/bash

# or
# try to avoid privileged flag, just add necessary capabilities when possible
# --device option allows you to run devices inside the container without the --privileged flag
docker run -it --device=/dev/ttyUSB0 -v $(pwd)/sdk:/opt/android-sdk thyrlian/android-sdk /bin/bash
```

Note:
* Connect Android device via USB on host first;
* Launch container;
* Disconnect and connect Android device on USB;
* Select OK for "Allow USB debugging" on Android device;
* Now the Android device will show up inside the container (`adb devices`).

Don't worry about `adbkey` or `adbkey.pub` under `/.android`, not required.

[Docker for Mac FAQ](https://docs.docker.com/docker-for-mac/faqs/#can-i-pass-through-a-usb-device-to-a-container) says:

> Unfortunately it is not possible to pass through a USB device (or a serial port) to a container.

## Android Commands Reference

* Check installed Android SDK tools version
```console
cat $ANDROID_HOME/tools/source.properties | grep Pkg.Revision
cat $ANDROID_HOME/platform-tools/source.properties | grep Pkg.Revision
```

> The "`android`" command is deprecated.  For command-line tools, use `tools/bin/sdkmanager` and `tools/bin/avdmanager`.

* List installed and available packages
```console
sdkmanager --list
# print full details instead of truncated path
sdkmanager --list --verbose
```

* Update all installed packages to the latest version
```bash
sdkmanager --update
```

* Install packages
> The packages argument is an SDK-style path as shown with the `--list` command, wrapped in quotes (for example, `"extras;android;m2repository"`). You can pass multiple package paths, separated with a space, but they must each be wrapped in their own set of quotes.
```bash
sdkmanager "extras;android;m2repository" "extras;google;m2repository" "extras;google;google_play_services" "extras;google;instantapps" "extras;m2repository;com;android;support;constraint;constraint-layout;1.0.2" "build-tools;26.0.0" "platforms;android-26"
```

* Stop emulator
```console
adb -s <device_sn> emu kill
```

## Demythologizing Memory

### OOM behaviour

Sometimes you may encounter OOM (Out of Memory) issue.  The issues vary in logs, while you could find the essence by checking the exit code (`echo $?`).

For demonstration, below examples try to execute [MemoryFiller](https://github.com/thyrlian/AndroidSDK/blob/master/misc/MemoryFiller/MemoryFiller.java) which can fill memory up quickly.

* **Exit Code** `137` (= 128 + 9 = SIGKILL = Killed)

  Example code:
  ```bash
  # spin up a container with memory limit (128MB)
  docker run -it -m 128m -v $(pwd)/misc/MemoryFiller:/root/MemoryFiller thyrlian/android-sdk /bin/bash
  # fill memory up
  cd /root/MemoryFiller && javac MemoryFiller.java
  java MemoryFiller
  ```

  Logs:
  ```console
  Killed
  ```

  Commentary: The process was in extreme resource starvation, thus was killed by the kernel OOM killer.  This happens when **JVM max heap size > actual container memory**.  Similarly, the logs could look like this when running a gradle task in an Android project: `Process 'Gradle Test Executor 1' finished with non-zero exit value 137`.

* **Exit Code** `1` (= SIGHUP = Hangup)

  Example code:
  ```bash
  # spin up a container with memory limit (or without - both lead to the same result)
  docker run -it -m 128m -v $(pwd)/misc/MemoryFiller:/root/MemoryFiller thyrlian/android-sdk /bin/bash
  # fill memory up
  # enable Docker memory limits transparency for JVM
  cd /root/MemoryFiller && javac MemoryFiller.java
  java -XX:+UnlockExperimentalVMOptions -XX:+UseCGroupMemoryLimitForHeap MemoryFiller
  ```

  Logs:
  ```console
  Exception in thread "main" java.lang.OutOfMemoryError: Java heap space
  	at MemoryFiller.main(MemoryFiller.java:13)
  ```

  Commentary: With [enabling Docker memory limits transparency for JVM](https://blogs.oracle.com/java-platform-group/java-se-support-for-docker-cpu-and-memory-limits), JVM is able to correctly estimate the max heap size, and it won't be killed by the kernel OOM killer any more.  Similarly, the logs could look like this when running a gradle task in an Android project: `Process 'Gradle Test Executor 1' finished with non-zero exit value 1`.  In this case, you should either check your code or tweak your memory limit for container (or JVM heap parameters, or even the host memory size).

* **Exit Code** `3` (= SIGQUIT = Quit)

  Example code:
  ```bash
  # spin up a container without memory limit
  docker run -it -v $(pwd)/misc/MemoryFiller:/root/MemoryFiller thyrlian/android-sdk /bin/bash
  # fill memory up
  cd /root/MemoryFiller && javac MemoryFiller.java
  # make sure that Docker memory resource is big enough > JVM max heap size
  # otherwise it's better to run with UnlockExperimentalVMOptions & UseCGroupMemoryLimitForHeap enabled
  java -XX:+ExitOnOutOfMemoryError MemoryFiller
  ```

  Logs:
  ```console
  Terminating due to java.lang.OutOfMemoryError: Java heap space
  ```

  Commentary: JRockit JVM exits on the first occurrence of an OOM error. It can be used if you prefer restarting an instance of JRockit JVM rather than handling OOM errors.

* **Exit Code** `134` (= 128 + 6 = SIGABRT = Abort)

  Example code:
  ```bash
  # spin up a container without memory limit
  docker run -it -v $(pwd)/misc/MemoryFiller:/root/MemoryFiller thyrlian/android-sdk /bin/bash
  # fill memory up
  cd /root/MemoryFiller && javac MemoryFiller.java
  # make sure that Docker memory resource is big enough > JVM max heap size
  # otherwise it's better to run with UnlockExperimentalVMOptions & UseCGroupMemoryLimitForHeap enabled
  java -XX:+CrashOnOutOfMemoryError MemoryFiller
  ```

  Logs:
  ```console
  Aborting due to java.lang.OutOfMemoryError: Java heap space
  #
  # A fatal error has been detected by the Java Runtime Environment:
  #
  #  Internal Error (debug.cpp:308), pid=63, tid=0x00007f208708d700
  #  fatal error: OutOfMemory encountered: Java heap space
  #
  # JRE version: OpenJDK Runtime Environment (8.0_131-b11) (build 1.8.0_131-8u131-b11-2ubuntu1.16.04.3-b11)
  # Java VM: OpenJDK 64-Bit Server VM (25.131-b11 mixed mode linux-amd64 compressed oops)
  # Failed to write core dump. Core dumps have been disabled. To enable core dumping, try "ulimit -c unlimited" before starting Java again
  #
  # An error report file with more information is saved as:
  # /root/MemoryFiller/hs_err_pid63.log
  #
  # If you would like to submit a bug report, please visit:
  #   http://bugreport.java.com/bugreport/crash.jsp
  #
  Aborted
  ```

  Commentary: JRockit JVM crashes and produces text and binary crash files when an OOM error occurs.  When JVM crashes with a fatal error, an error report file `hs_err_pid***.log` will be generated in the same working directory.

### Facts

* JVM is not container aware, and always guesses about the memory resource.
* Many tools (such as `free`, `vmstat`, `top`) were invented before the existence of [cgroups](https://en.wikipedia.org/wiki/Cgroups), thus they have no clue about the resources limits.
* `MaxRAMFraction`: maximum fraction (1/n) of real memory used for maximum heap size, the default value is 4.
* `MaxMetaspaceSize`: where class metadata reside.  `MaxPermSize` is deprecated in JDK 8.  It used to be Permanent Generation space before JDK 8, which could cause `java.lang.OutOfMemoryError: PermGen` problem.
* `-XshowSettings:category`: shows settings and continues. Possible category arguments for this option include the following: `all` (all categories of settings, the default value), `locale` (settings related to locale), `properties` (settings related to system properties), `vm` (settings of the JVM).  To get JVM Max Heap Size, simply run `java -XshowSettings:vm -version`
* `PrintFlagsFinal`: print all VM flags after argument and ergonomic processing.  You can run `java -XX:+PrintFlagsFinal -version` to get all information.
* By default, [Android Gradle Plugin](https://google.github.io/android-gradle-dsl/current/com.android.build.gradle.internal.dsl.DexOptions.html) sets the maxProcessCount to 4 (the maximum number of concurrent processes that can be used to dex).  `Total Memory = maxProcessCount * javaMaxHeapSize`
* Set the environment variable `_JAVA_OPTIONS` to `-XX:+UnlockExperimentalVMOptions -XX:+UseCGroupMemoryLimitForHeap`.  Then you'll see such logs like `Picked up _JAVA_OPTIONS: -XX:+UnlockExperimentalVMOptions -XX:+UseCGroupMemoryLimitForHeap` during any task execution, which means it takes effect.
* `JAVA_OPTS` environment variable won't be used by JVM directly, but sometimes get recognized by other apps (e.g. Apache Tomcat) as configuration.  If you want to use it for any Java executable, do it like this: `java $JAVA_OPTS ...`
* The official `JAVA_TOOL_OPTIONS` environment variable is provided to augment a command line, so that command line options can be passed without accessing or modifying the launch command.  It is recognized by all VMs.
* You can tweak `-Xms` or `-Xmx` on your own to specify the initial or maximum heap size.

## Changelog

See [here](https://github.com/thyrlian/AndroidSDK/blob/master/CHANGELOG.md).

## License

Copyright (c) 2016-2017 Jing Li. It is released under the [Apache License](https://www.apache.org/licenses/LICENSE-2.0). See the [LICENSE](https://raw.githubusercontent.com/thyrlian/AndroidSDK/master/LICENSE) file for details.

By continuing to use this Docker Image, you accept the terms in below license agreement.

* [Android Software Development Kit License Agreement](https://raw.githubusercontent.com/thyrlian/AndroidSDK/master/EULA/AndroidSoftwareDevelopmentKitLicenseAgreement) (or read it [here](https://developer.android.com/studio/terms.html))
* [Android SDK Preview License Agreement](https://raw.githubusercontent.com/thyrlian/AndroidSDK/master/EULA/AndroidSDKPreviewLicenseAgreement)
* [Intel Android Extra License](https://raw.githubusercontent.com/thyrlian/AndroidSDK/master/EULA/IntelAndroidExtraLicense)
