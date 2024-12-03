#!/usr/bin/env bash

set -euo pipefail

# download all episodes from 0001 to 1000
for i in {1..1000}; do
  url="https://twit.cachefly.net/audio/sn/sn$(printf "%04d" $i)/sn$(printf "%04d" $i).mp3"
  wget -c $url
done
