# Contributing

Contributions are made by forking this repository, making the changes, and opening a pull request.

## Updating Guide

[README](./README.md) is the first place where people are looking for help.  Please remember to add or update the corresponding part in README, especially the hidden piece which is not told by code.

## Accepting New SDK Licenses

Update the script [`android-sdk/license_acceptor.sh`](./android-sdk/license_accepter.sh) with the new agreement checksums.  Do not remove pre-existing license agreement acceptances.

If a new agreement is accepted, a file should be created in the directory [`EULA`](./EULA).  If there is an update, ensure the agreements contain a suffix with the timestamp in the format `-YYYYMMDD`.

## Passing All Checks

Make sure that all [tests](./.travis.yml) pass on the CI.
