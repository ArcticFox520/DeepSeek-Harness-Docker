#!/bin/bash
set -e

dsh web &
DSH_PID=$!

for i in $(seq 1 30); do
  curl -s -o /dev/null http://127.0.0.1:3080 && break
  sleep 1
done

socat TCP-LISTEN:3080,fork,reuseaddr TCP:127.0.0.1:3080 &
SOCAT_PID=$!

wait -n $DSH_PID $SOCAT_PID
exit $?
