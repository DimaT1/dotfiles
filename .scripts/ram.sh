#!/usr/bin/env sh

free -m | sed -n 2p | awk '{print $3}'
