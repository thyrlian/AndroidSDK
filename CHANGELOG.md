# Changelog

## 9.3

**Main Image**

```console
docker pull thyrlian/android-sdk:9.3
```

**What's New**
* Upgraded Ubuntu from 22.04.3 to 22.04.4
* Upgraded OpenJDK from 17.0.8.1 to 17.0.10
* Upgraded Gradle from 8.3 to 8.7
* Upgraded Kotlin compiler from 1.9.10 to 1.9.23
* Upgraded Android SDK Command-line Tools from 11.0 to 13.0

Component | Version
--------- | -------
Ubuntu | 22.04.4 LTS (Jammy Jellyfish)
Java | 17.0.10
Gradle | 8.7
Kotlin compiler | 1.9.23
Android SDK Command-line Tools | 13.0
OpenSSH | 1:8.9p1-3

**Sub-image**: VNC

```console
docker pull thyrlian/android-sdk-vnc:9.3
```

Component | Version
--------- | -------
TightVNC | 1.3.10

**Sub-image**: Firebase Test Lab

```console
docker pull thyrlian/android-sdk-firebase-test-lab:9.3
```

**What's New**
* Upgraded Google Cloud SDK from 447.0.0 to 471.0.0

Component | Version
--------- | -------
Google Cloud SDK | 471.0.0

---

## 9.2

**Main Image**

```console
docker pull thyrlian/android-sdk:9.2
```

**What's New**
* Upgraded Ubuntu from 22.04.2 to 22.04.3
* Upgraded OpenJDK from 17.0.7 to 17.0.8.1
* Upgraded Gradle from 8.1.1 to 8.3
* Upgraded Kotlin compiler from 1.8.21 to 1.9.10
* Upgraded Android SDK Command-line Tools from 9.0 to 11.0

Component | Version
--------- | -------
Ubuntu | 22.04.3 LTS (Jammy Jellyfish)
Java | 17.0.8.1
Gradle | 8.3
Kotlin compiler | 1.9.10
Android SDK Command-line Tools | 11.0
OpenSSH | 1:8.9p1-3

**Sub-image**: VNC

```console
docker pull thyrlian/android-sdk-vnc:9.2
```

Component | Version
--------- | -------
TightVNC | 1.3.10

**Sub-image**: Firebase Test Lab

```console
docker pull thyrlian/android-sdk-firebase-test-lab:9.2
```

**What's New**
* Upgraded Google Cloud SDK from 432.0.0 to 447.0.0

Component | Version
--------- | -------
Google Cloud SDK | 447.0.0

---

## 9.1

Replace [environment variable](https://developer.android.com/tools/variables#envar) `ANDROID_SDK_ROOT` (deprecated) with `ANDROID_HOME`

**Main Image**

```console
docker pull thyrlian/android-sdk:9.1
```

**What's New**
* Upgraded OpenJDK from 17.0.6 to 17.0.7
* Upgraded Kotlin compiler from 1.8.20 to 1.8.21

Component | Version
--------- | -------
Ubuntu | 22.04.2 LTS (Jammy Jellyfish)
Java | 17.0.7
Gradle | 8.1.1
Kotlin compiler | 1.8.21
Android SDK Command-line Tools | 9.0
OpenSSH | 1:8.9p1-3

**Variant Image**

```console
docker pull thyrlian/android-sdk-jdk11:9.1
```

**What's New**
* Upgraded OpenJDK from 11.0.18 to 11.0.19

Component | Version
--------- | -------
Java | 11.0.19

**Sub-image**: VNC

```console
docker pull thyrlian/android-sdk-vnc:9.1
```

Component | Version
--------- | -------
TightVNC | 1.3.10

**Sub-image**: Firebase Test Lab

```console
docker pull thyrlian/android-sdk-firebase-test-lab:9.1
```

**What's New**
* Upgraded Google Cloud SDK from 427.0.0 to 432.0.0

Component | Version
--------- | -------
Google Cloud SDK | 432.0.0

---

## 9.0

**Main Image**

```console
docker pull thyrlian/android-sdk:9.0
```

**What's New**
* Upgraded Ubuntu from 22.04.1 to 22.04.2
* Upgraded OpenJDK from 11.0.15 to 17.0.6
* Upgraded Gradle from 7.4.2 to 8.1.1
* Upgraded Kotlin compiler from 1.6.21 to 1.8.20
* Upgraded Android SDK Command-line Tools from 6.0 to 9.0

Component | Version
--------- | -------
Ubuntu | 22.04.2 LTS (Jammy Jellyfish)
Java | 17.0.6
Gradle | 8.1.1
Kotlin compiler | 1.8.20
Android SDK Command-line Tools | 9.0
OpenSSH | 1:8.9p1-3

**Variant Image**

```console
docker pull thyrlian/android-sdk-jdk11:9.0
```

**What's New**
* Upgraded OpenJDK from 1.8.0_312 to 11.0.18

Component | Version
--------- | -------
Java | 11.0.18

**Sub-image**: VNC

```console
docker pull thyrlian/android-sdk-vnc:9.0
```

Component | Version
--------- | -------
TightVNC | 1.3.10

**Sub-image**: Firebase Test Lab

```console
docker pull thyrlian/android-sdk-firebase-test-lab:9.0
```

**What's New**
* Upgraded Google Cloud SDK from 385.0.0 to 427.0.0

Component | Version
--------- | -------
Google Cloud SDK | 427.0.0

---

## 8.0

**Main Image**

```console
docker pull thyrlian/android-sdk:8.0
```

**What's New**
* Upgraded Ubuntu from 20.04.3 to 22.04.1
* Upgraded OpenJDK from 11.0.13 to 11.0.15
* Upgraded Gradle from 7.3.3 to 7.4.2
* Upgraded Kotlin compiler from 1.6.10 to 1.6.21
* Upgraded OpenSSH from 1:8.2p1-4 to 1:8.9p1-3

Component | Version
--------- | -------
Ubuntu | 22.04.1 LTS (Jammy Jellyfish)
Java | 11.0.15
Gradle | 7.4.2
Kotlin compiler | 1.6.21
Android SDK Command-line Tools | 6.0
OpenSSH | 1:8.9p1-3

**Variant Image**

```console
docker pull thyrlian/android-sdk-jdk8:8.0
```

Component | Version
--------- | -------
Java | 1.8.0_312

**Sub-image**: VNC

```console
docker pull thyrlian/android-sdk-vnc:8.0
```

Component | Version
--------- | -------
TightVNC | 1.3.10

**Sub-image**: Firebase Test Lab

```console
docker pull thyrlian/android-sdk-firebase-test-lab:8.0
```

**What's New**
* Upgraded Google Cloud SDK from 371.0.0 to 385.0.0

Component | Version
--------- | -------
Google Cloud SDK | 385.0.0

---

## 7.2

**Main Image**

```console
docker pull thyrlian/android-sdk:7.2
```

**What's New**
* Upgraded OpenJDK from 11.0.11 to 11.0.13
* Upgraded Gradle from 7.2 to 7.3.3
* Upgraded Kotlin compiler from 1.5.31 to 1.6.10
* Upgraded Android SDK Command-line Tools from 5.0 to 6.0

Component | Version
--------- | -------
Ubuntu | 20.04.3 LTS (Focal Fossa)
Java | 11.0.13
Gradle | 7.3.3
Kotlin compiler | 1.6.10
Android SDK Command-line Tools | 6.0
OpenSSH | 1:8.2p1-4

**Variant Image**

```console
docker pull thyrlian/android-sdk-jdk8:7.2
```

**What's New**
* Upgraded OpenJDK from 1.8.0_292 to 1.8.0_312

Component | Version
--------- | -------
Java | 1.8.0_312

**Sub-image**: VNC

```console
docker pull thyrlian/android-sdk-vnc:7.2
```

Component | Version
--------- | -------
TightVNC | 1.3.10

**Sub-image**: Firebase Test Lab

```console
docker pull thyrlian/android-sdk-firebase-test-lab:7.2
```

**What's New**
* Upgraded Google Cloud SDK from 360.0.0 to 371.0.0

Component | Version
--------- | -------
Google Cloud SDK | 371.0.0

---

## 7.1

**Main Image**

```console
docker pull thyrlian/android-sdk:7.1
```

**What's New**
* Upgraded Ubuntu from 20.04.2 to 20.04.3
* Upgraded Gradle from 7.1.1 to 7.2
* Upgraded Kotlin compiler from 1.5.21 to 1.5.31
* Upgraded Android SDK Command-line Tools from 4.0 to 5.0

Component | Version
--------- | -------
Ubuntu | 20.04.3 LTS (Focal Fossa)
Java | 11.0.11
Gradle | 7.2
Kotlin compiler | 1.5.31
Android SDK Command-line Tools | 5.0
OpenSSH | 1:8.2p1-4

**Variant Image**

```console
docker pull thyrlian/android-sdk-jdk8:7.1
```

Component | Version
--------- | -------
Java | 1.8.0_292

**Sub-image**: VNC

```console
docker pull thyrlian/android-sdk-vnc:7.1
```

Component | Version
--------- | -------
TightVNC | 1.3.10

**Sub-image**: Firebase Test Lab

```console
docker pull thyrlian/android-sdk-firebase-test-lab:7.1
```

**What's New**
* Upgraded Google Cloud SDK from 349.0.0 to 360.0.0

Component | Version
--------- | -------
Google Cloud SDK | 360.0.0

---

## 7.0

**Main Image**

```console
docker pull thyrlian/android-sdk:7.0
```

**What's New**
* Upgraded OpenJDK from 1.8.0_292 to 11.0.11
* Upgraded Gradle from 6.9 to 7.1.1
* Upgraded Kotlin compiler from 1.5.0 to 1.5.21

Component | Version
--------- | -------
Ubuntu | 20.04.2 LTS (Focal Fossa)
Java | 11.0.11
Gradle | 7.1.1
Kotlin compiler | 1.5.21
Android SDK Command-line Tools | 4.0
OpenSSH | 1:8.2p1-4

**Variant Image**

```console
docker pull thyrlian/android-sdk-jdk8:7.0
```

Component | Version
--------- | -------
Java | 1.8.0_292

**Sub-image**: VNC

```console
docker pull thyrlian/android-sdk-vnc:7.0
```

Component | Version
--------- | -------
TightVNC | 1.3.10

**Sub-image**: Firebase Test Lab

```console
docker pull thyrlian/android-sdk-firebase-test-lab:7.0
```

**What's New**
* Upgraded Google Cloud SDK from 340.0.0 to 349.0.0

Component | Version
--------- | -------
Google Cloud SDK | 349.0.0

---

## 6.1

**Main Image**

```console
docker pull thyrlian/android-sdk:6.1
```

**What's New**
* Upgraded Ubuntu from 20.04.1 to 20.04.2
* Upgraded OpenJDK from 1.8.0_272 to 1.8.0_292
* Upgraded Gradle from 6.7 to 6.9
* Upgraded Kotlin compiler from 1.4.10 to 1.5.0
* Upgraded Android SDK Command-line Tools from 3.0 to 4.0

Component | Version
--------- | -------
Ubuntu | 20.04.2 LTS (Focal Fossa)
Java | 1.8.0_292
Gradle | 6.9
Kotlin compiler | 1.5.0
Android SDK Command-line Tools | 4.0
OpenSSH | 1:8.2p1-4

**Sub-image**: VNC

```console
docker pull thyrlian/android-sdk-vnc:6.1
```

Component | Version
--------- | -------
TightVNC | 1.3.10

**Sub-image**: Firebase Test Lab

```console
docker pull thyrlian/android-sdk-firebase-test-lab:6.1
```

**What's New**
* Upgraded Google Cloud SDK from 318.0.0 to 340.0.0

Component | Version
--------- | -------
Google Cloud SDK | 340.0.0

---

## 6.0

**Main Image**

```console
docker pull thyrlian/android-sdk:6.0
```

**What's New**
* Upgraded Ubuntu from 20.04 to 20.04.1
* Upgraded OpenJDK from 1.8.0_252 to 1.8.0_272
* Upgraded Gradle from 6.4.1 to 6.7
* Upgraded Kotlin compiler from 1.3.72 to 1.4.10
* Upgraded Android SDK Command-line Tools from 2.0 to 3.0

Component | Version
--------- | -------
Ubuntu | 20.04.1 LTS (Focal Fossa)
Java | 1.8.0_272
Gradle | 6.7
Kotlin compiler | 1.4.10
Android SDK Command-line Tools | 3.0
OpenSSH | 1:8.2p1-4

**Sub-image**: VNC

```console
docker pull thyrlian/android-sdk-vnc:6.0
```

Component | Version
--------- | -------
TightVNC | 1.3.10

**Sub-image**: Firebase Test Lab

```console
docker pull thyrlian/android-sdk-firebase-test-lab:6.0
```

Component | Version
--------- | -------
Google Cloud SDK | 318.0.0

---

## 5.0

```console
docker pull thyrlian/android-sdk:5.0
```

**What's New**
* Upgraded Ubuntu from 18.04.4 to 20.04
* Upgraded OpenJDK from 1.8.0_242 to 1.8.0_252
* Upgraded Gradle from 6.3 to 6.4.1
* Upgraded Kotlin compiler from 1.3.71 to 1.3.72
* Upgraded Android SDK Command-line Tools from 1.0.0 to 2.0
* Upgraded OpenSSH from 1:7.6p1-4 to 1:8.2p1-4

Component | Version
--------- | -------
Ubuntu | 20.04 LTS (Focal Fossa)
Java | 1.8.0_252
Gradle | 6.4.1
Kotlin compiler | 1.3.72
Android SDK Command-line Tools | 2.0
OpenSSH | 1:8.2p1-4

---

## 4.0

```console
docker pull thyrlian/android-sdk:4.0
```

**What's New**
* Upgraded Ubuntu from 18.04.3 to 18.04.4
* Upgraded Gradle from 6.1.1 to 6.3
* Upgraded Kotlin compiler from 1.3.61 to 1.3.71
* Upgraded from AndroidSDK 26.1.1 to Android SDK Tools 1.0.0
* Added environment variable QTWEBENGINE_DISABLE_SANDBOX

Component | Version
--------- | -------
Ubuntu | 18.04.4 LTS (Bionic Beaver)
Java | 1.8.0_242
Gradle | 6.3
Kotlin compiler | 1.3.71
Android SDK Tools | 1.0.0
OpenSSH | 1:7.6p1-4

---

## 3.1

```console
docker pull thyrlian/android-sdk:3.1
```

**What's New**
* Upgraded Ubuntu from 18.04.2 to 18.04.3
* Upgraded OpenJDK from 1.8.0_191 to 1.8.0_242
* Upgraded Gradle from 5.2.1 to 6.1.1
* Upgraded Kotlin compiler from 1.3.21 to 1.3.61

Component | Version
--------- | -------
Ubuntu | 18.04.3 LTS (Bionic Beaver)
Java | 1.8.0_242
Gradle | 6.1.1
Kotlin compiler | 1.3.61
AndroidSDK | 26.1.1
OpenSSH | 1:7.6p1-4

---

## 3.0

```console
docker pull thyrlian/android-sdk:3.0
```

**What's New**
* Reduced image size by removal of unnecessary package installation
* Upgraded Ubuntu from 16.04.x to 18.04.2
* Upgraded Gradle from 4.10.3 to 5.2.1
* Upgraded Kotlin compiler from 1.3.11 to 1.3.21
* Upgraded OpenSSH from 1:7.2p2-4 to 1:7.6p1-4

Component | Version
--------- | -------
Ubuntu | 18.04.2 LTS (Bionic Beaver)
Java | 1.8.0_191
Gradle | 5.2.1
Kotlin compiler | 1.3.21
AndroidSDK | 26.1.1
OpenSSH | 1:7.6p1-4

---

## 2.6

```console
docker pull thyrlian/android-sdk:2.6
```

**What's New**
* Upgraded Ubuntu from 16.04.5 to 16.04.6

Component | Version
--------- | -------
Ubuntu | 16.04.6 LTS (Xenial Xerus)
Java | 1.8.0_191
Gradle | 4.10.3
Kotlin compiler | 1.3.11
AndroidSDK | 26.1.1
OpenSSH | 1:7.2p2-4

---

## 2.5

```console
docker pull thyrlian/android-sdk:2.5
```

**What's New**
* Upgraded OpenJDK from 1.8.0_181 to 1.8.0_191
* Upgraded Gradle from 4.10 to 4.10.3
* Upgraded Kotlin compiler from 1.2.61 to 1.3.11

Component | Version
--------- | -------
Ubuntu | 16.04.5 LTS (Xenial Xerus)
Java | 1.8.0_191
Gradle | 4.10.3
Kotlin compiler | 1.3.11
AndroidSDK | 26.1.1
OpenSSH | 1:7.2p2-4

---

## 2.4

```console
docker pull thyrlian/android-sdk:2.4
```

**What's New**
* Upgraded Ubuntu from 16.04.4 to 16.04.5
* Upgraded OpenJDK from 1.8.0_171 to 1.8.0_181
* Upgraded Gradle from 4.8.1 to 4.10
* Upgraded Kotlin compiler from 1.2.50 to 1.2.61

Component | Version
--------- | -------
Ubuntu | 16.04.5 LTS (Xenial Xerus)
Java | 1.8.0_181
Gradle | 4.10
Kotlin compiler | 1.2.61
AndroidSDK | 26.1.1
OpenSSH | 1:7.2p2-4

---

## 2.3

```console
docker pull thyrlian/android-sdk:2.3
```

**What's New**
* Upgraded Gradle from 4.7 to 4.8.1
* Upgraded Kotlin compiler from 1.2.41 to 1.2.50
* Upgraded AndroidSDK from 26.0.1 to 26.1.1

Component | Version
--------- | -------
Ubuntu | 16.04.4 LTS (Xenial Xerus)
Java | 1.8.0_171
Gradle | 4.8.1
Kotlin compiler | 1.2.50
AndroidSDK | 26.1.1
OpenSSH | 1:7.2p2-4

---

## 2.2

```console
docker pull thyrlian/android-sdk:2.2
```

**What's New**
* Upgraded Ubuntu from 16.04.3 to 16.04.4
* Upgraded OpenJDK from 1.8.0_151 to 1.8.0_171
* Upgraded Gradle from 4.6 to 4.7
* Upgraded Kotlin compiler from 1.2.30 to 1.2.41

Component | Version
--------- | -------
Ubuntu | 16.04.4 LTS (Xenial Xerus)
Java | 1.8.0_171
Gradle | 4.7
Kotlin compiler | 1.2.41
AndroidSDK | 26.0.1
OpenSSH | 1:7.2p2-4

---

## 2.1

```console
docker pull thyrlian/android-sdk:2.1
```

**What's New**
* Upgraded Gradle from 4.4.1 to 4.6
* Upgraded Kotlin compiler from 1.2.10 to 1.2.30

Component | Version
--------- | -------
Ubuntu | 16.04.3 LTS (Xenial Xerus)
Java | 1.8.0_151
Gradle | 4.6
Kotlin compiler | 1.2.30
AndroidSDK | 26.0.1
OpenSSH | 1:7.2p2-4

---

## 2.0

```console
docker pull thyrlian/android-sdk:2.0
```

**What's New**
* Added launching adb server on container start
* Upgraded Ubuntu from 16.04.2 to 16.04.3
* Upgraded Java from 1.8.0_131 to 1.8.0_151
* Upgraded Gradle from 4.2.1 to 4.4.1
* Upgraded Kotlin compiler from 1.1.51 to 1.2.10

Component | Version
--------- | -------
Ubuntu | 16.04.3 LTS (Xenial Xerus)
Java | 1.8.0_151
Gradle | 4.4.1
Kotlin compiler | 1.2.10
AndroidSDK | 26.0.1
OpenSSH | 1:7.2p2-4

---

## 1.8

```console
docker pull thyrlian/android-sdk:1.8
```

**What's New**
* Upgraded Gradle from 4.1 to 4.2.1
* Upgraded Kotlin compiler from 1.2-M2 to 1.1.51

Component | Version
--------- | -------
Ubuntu | 16.04.2 LTS (Xenial Xerus)
Java | 1.8.0_131
Gradle | 4.2.1
Kotlin compiler | 1.1.51
AndroidSDK | 26.0.1
OpenSSH | 1:7.2p2-4

---

## 1.7

```console
docker pull thyrlian/android-sdk:1.7
```

**What's New**
* Upgraded Gradle from 4.0.1 to 4.1
* Upgraded Kotlin compiler from 1.1.3-2 to 1.2-M2
* Applied emulator fix

Component | Version
--------- | -------
Ubuntu | 16.04.2 LTS (Xenial Xerus)
Java | 1.8.0_131
Gradle | 4.1
Kotlin compiler | 1.2-M2
AndroidSDK | 26.0.1
OpenSSH | 1:7.2p2-4

---

## 1.6

```console
docker pull thyrlian/android-sdk:1.6
```

**What's New**
* Added Kotlin compiler

Component | Version
--------- | -------
Ubuntu | 16.04.2 LTS (Xenial Xerus)
Java | 1.8.0_131
Gradle | 4.0.1
Kotlin compiler | 1.1.3-2
AndroidSDK | 26.0.1
OpenSSH | 1:7.2p2-4

---

## 1.5

```console
docker pull thyrlian/android-sdk:1.5
```

**What's New**
* Applied emulator fix

Component | Version
--------- | -------
Ubuntu | 16.04.2 LTS (Xenial Xerus)
Java | 1.8.0_131
Gradle | 4.0
AndroidSDK | 26.0.1
OpenSSH | 1:7.2p2-4

---

## 1.4

```console
docker pull thyrlian/android-sdk:1.4
```

**What's New**
* Upgraded Ubuntu from 16.04.1 to 16.04.2
* Upgraded Gradle from 3.5 to 4.0

Component | Version
--------- | -------
Ubuntu | 16.04.2 LTS (Xenial Xerus)
Java | 1.8.0_131
Gradle | 4.0
AndroidSDK | 26.0.1
OpenSSH | 1:7.2p2-4

---

## 1.3

```console
docker pull thyrlian/android-sdk:1.3
```

**What's New**
* Upgraded Gradle from 3.3 to 3.5
* Upgraded AndroidSDK from 25.2.3 to 26.0.1

Component | Version
--------- | -------
Ubuntu | 16.04.1 LTS (Xenial Xerus)
Java | 1.8.0_131
Gradle | 3.5
AndroidSDK | 26.0.1
OpenSSH | 1:7.2p2-4

---

## 1.2

```console
docker pull thyrlian/android-sdk:1.2
```

**What's New**
* Upgraded Gradle from 3.2.1 to 3.3

Component | Version
--------- | -------
Ubuntu | 16.04.1 LTS (Xenial Xerus)
Java | 1.8.0_121
Gradle | 3.3
AndroidSDK | 25.2.3
OpenSSH | 1:7.2p2-4

---

## 1.1

```console
docker pull thyrlian/android-sdk:1.1
```

**What's New**
* Added SSH server and configurations

Component | Version
--------- | -------
Ubuntu | 16.04.1 LTS (Xenial Xerus)
Java | 1.8.0_121
Gradle | 3.2.1
AndroidSDK | 25.2.3
OpenSSH | 1:7.2p2-4

---

## 1.0

```console
docker pull thyrlian/android-sdk:1.0
```

Component | Version
--------- | -------
Ubuntu | 16.04.1 LTS (Xenial Xerus)
Java | 1.8.0_121
Gradle | 3.2.1
AndroidSDK | 25.2.3
