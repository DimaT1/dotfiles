#!/usr/bin/env sh

sensors | awk '/Package/{print $4}'
