#!/bin/bash

# Using grep to check the response line because end may contain hidden CTRL-M character
VAR=$(curl -m1 -Is "http://localhost:8080/backend/versioninfo/version" | head -n 1 | grep "HTTP/1.1 200")
if [[ -z "$VAR" ]]
then
  # Exit with error code
  exit 1
fi
