# AndroidSDK

Android SDK Docker Image (including Gradle build tool)

[![Docker Hub](https://img.shields.io/badge/Docker%20Hub-info-blue.svg)](https://hub.docker.com/r/thyrlian/android-sdk/)
[![Build Status](https://travis-ci.org/thyrlian/AndroidSDK.svg?branch=master)](https://travis-ci.org/thyrlian/AndroidSDK)

<img src="https://github.com/thyrlian/AndroidSDK/blob/master/logo.png?raw=true" width="200">

## Philosophy

Provide only the barebone SDK (the latest official minimal package) gives you the most flexibility in tailoring your own SDK tools for your project.  You can maintain an external persistent SDK directory, and mount it to any container.  In this way, you don't have to waste time on downloading over and over again, meanwhile, without having any unnecessary package.

## Caveat

Run Android SDK update directly within the **Dockerfile** or inside the **container** would fail if the storage driver is `AUFS` (by default), it is due to some file operations (during updating) are not supported by this storage driver, but changing it to `Btrfs` would work.  However, as said, it's recommended to update the SDK from the external volume on host.

What happens if it fails?
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

## Getting Started

Set the working directory to the root of this project, if you want to build the image by yourself.

```bash
# build the image
docker build -t android-sdk android-sdk
# or pull the image
docker pull thyrlian/android-sdk

# below commands assume that you've pulled the image

# copy the pre-downloaded SDK to the mounted 'sdk' directory
echo "cp -a \$ANDROID_HOME/. /sdk" | docker run -i -v $(pwd)/sdk:/sdk thyrlian/android-sdk && docker stop $(docker ps -a -q) > /dev/null && docker rm $(docker ps -a -q) > /dev/null

# go to the 'sdk' directory on the host which has persisted data, update the SDK
echo "y" | sdk/tools/android update sdk ...

# mount the updated SDK to container again
docker run -it -v $(pwd)/sdk:/opt/android-sdk thyrlian/android-sdk /bin/bash
```
You can share the updated SDK directory from the host to any container.  For non-Btrfs users, do remember, always update from the host, not inside the container.

## Android Commands Reference

* Check installed Android SDK tools version
```console
cat $ANDROID_HOME/tools/source.properties | grep Pkg.Revision
cat $ANDROID_HOME/platform-tools/source.properties | grep Pkg.Revision
```

* List installed and available packages
```console
sdkmanager --list
```

* List available packages from remote SDK repository
```console
android list sdk -e
```

* Update the SDK
```console
# by name
echo "y" | android update sdk --no-ui --all --filter tools,platform-tools,extra-android-m2repository,build-tools-25.0.0,android-25

# by id
echo "y" | android update sdk -u -a -t 1,2,3,...,n
```

## Version History

**[1.0](https://hub.docker.com/r/thyrlian/android-sdk/tags/)** `docker pull thyrlian/android-sdk:1.0`

Component | Version
--------- | -------
Ubuntu | 16.04.1 LTS (Xenial Xerus)
Java | 1.8.0_111
Gradle | 3.2.1
AndroidSDK | 25.2.3

## License

Copyright (c) 2016 Jing Li. It is released under the [MIT License](http://opensource.org/licenses/MIT). See the [LICENSE](https://github.com/thyrlian/AndroidSDK/blob/master/LICENSE) file for details.
