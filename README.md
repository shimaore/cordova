OpenJDK + Android Tools + Node.js + Cordova

[Docker Hub Automated Build](https://hub.docker.com/r/shimaore/cordova/)

To use the `cordova` command to create and build your project,
```bash
alias cordova='docker run -ti --rm --wordir /opt/src $(pwd):/opt/src shimaore/cordova cordova'
```
then [follow the guide](https://cordova.apache.org/docs/en/latest/guide/cli/index.html#create-the-app).

Need USB for `cordova run`?
```bash
alias cordova='docker run -ti --rm --wordir /opt/src $(pwd):/opt/src --privileged -v /dev/bus/usb:/dev/bus/usb shimaore/cordova cordova'
```
