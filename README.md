# AndroidSDK

Android SDK Docker Image

[![](https://img.shields.io/badge/Docker%20Hub-info-blue.svg)](https://hub.docker.com/r/thyrlian/android-sdk/)
[![Build Status](https://travis-ci.org/thyrlian/AndroidSDK.svg?branch=master)](https://travis-ci.org/thyrlian/AndroidSDK)

<img src="https://github.com/thyrlian/AndroidSDK/blob/master/logo.png?raw=true" width="200">

## Important Notes

Run Android SDK update directly from the **Dockerfile** or inside the **container** would fail with the default `AUFS` storage driver, due to some file operations are not supported by this storage driver, but change it to `Btrfs` would work.

* Check Docker's current storage driver option
```console
docker info | grep 'Storage Driver'
```

* Check which filesystems are supported by the running host kernel
```console
cat /proc/filesystems
```

## Getting Started

**Only for non-Btrfs users**

Set the working directory to the root of this project.

```console
# build the docker image
docker build -t android-sdk android-sdk

# run the docker container, mount an empty directory 'sdk' from host to the container
docker run -it -v $(pwd)/sdk:/sdk android-sdk /bin/bash

# copy the downloaded SDK to the mounted 'sdk' directory
cp -a $ANDROID_HOME/. /sdk

# quit the container
exit

# stop and remove the container
docker stop $(docker ps -a -q) && docker rm $(docker ps -a -q)

# go to the 'sdk' directory on the host which has persisted data, update SDK
sdk/tools/android update sdk ...

# mount the updated SDK to container again
docker run -it -v $(pwd)/sdk:/opt/android-sdk-linux android-sdk /bin/bash
```
You can share the updated SDK directory from the host to any container, and remember, always update from the host, not inside container.

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

## License

Copyright (c) 2016 Jing Li. It is released under the [MIT License](http://opensource.org/licenses/MIT). See the [LICENSE](https://github.com/thyrlian/AndroidSDK/blob/master/LICENSE) file for details.
