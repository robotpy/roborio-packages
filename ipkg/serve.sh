#!/bin/bash
#
# Starts a webserver that serves the -dev directory for
# testing purposes
#

cd $(dirname $0)
exec python3 -m http.server -d 2019-dev 1234
