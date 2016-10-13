# AndroidSDK

Android SDK Docker Image

[![](https://img.shields.io/badge/Docker%20Hub-info-blue.svg)](https://hub.docker.com/r/thyrlian/android-sdk/)

<img src="https://github.com/thyrlian/AndroidSDK/blob/master/Images/AndroidSDK.png?raw=true" width="200">

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

## Android Commands Reference

* Check installed Android SDK tools version
```console
cat $ANDROID_HOME/tools/source.properties | grep Pkg.Revision
cat $ANDROID_HOME/platform-tools/source.properties | grep Pkg.Revision
```

* List available packages from remote SDK repository
```console
android list sdk -e
```

* Update the SDK
```console
# by name
echo "y" | android update sdk --no-ui --all --filter tools,platform-tools,build-tools-24.0.1,android-24

# by id
echo "y" | android update sdk -u -a -t 1,2,3,...,n
```
