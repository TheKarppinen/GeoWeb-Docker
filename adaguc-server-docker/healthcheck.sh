#!/bin/bash

# Using grep to check the response line because end may contain hidden CTRL-M character
VAR=$(curl -m1 -Is "http://localhost:8080/adaguc-services/wms?SERVICE=WMS&REQUEST=GetCapabilities" | head -n 1 | grep "HTTP/1.1 200 OK")
if [[ -z "$VAR" ]]
then
  # Exit with error code
  exit 1
fi
