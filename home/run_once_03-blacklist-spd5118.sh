#!/bin/bash
sudo tee /etc/modprobe.d/blacklist-spd5118.conf <<EOF
blacklist spd5118
EOF
sudo dracut --force
