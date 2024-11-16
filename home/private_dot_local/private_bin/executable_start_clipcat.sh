#!/bin/bash

# Remove existing socket file if it exists
rm -f /run/user/$(id -u)/clipcat/grpc.sock

# Start clipcat daemon
/usr/bin/clipcatd --replace
