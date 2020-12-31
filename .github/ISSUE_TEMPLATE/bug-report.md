---
name: Bug Report
about: Create a report to inform us any issue
title: "[BUG]"
labels: bug
assignees: thyrlian

---

## NOTE

Before filling out this bug template, please **think twice**: if the issue is really on our side, instead of a problem from the Android SDK.  Because this Docker image merely provides a container environment, we don't redistribute or revise the Android SDK (as described in the README, we advise you to mount Android SDK from your host machine to the container).  In order to **narrow down the problem**, try to reproduce the issue on a different environment (e.g. on your host machine, better to be a clean environment), try to shrink the scope (whether during the compiling phase or with the emulator), to see if the issue still occurs.

---

### Description

A concise description of what the bug is.

### Steps To Reproduce

Steps to reproduce the issue (do make sure that you're able to reproduce the issue when following the steps below).

1. `...`
2. `...`
3. `...`

### Actual Result

A concise description of what happened.

### Expected Behavior

A concise description of what you expected to happen.

### Environment

 - Docker image tag [e.g. `thyrlian/android-sdk:1.0`]
 - Host machine [e.g. Linux, macOS, Windows, cloud instance]
 - Android SDK version

### Additional Information

Any information you think would help to understand/reproduce/debug/fix the issue.
