#!/bin/bash

rm -f /run/user/$(id -u)/clipcat/grpc.sock
/usr/bin/clipcatd --no-daemon --replace
