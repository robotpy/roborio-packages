#!/bin/bash
#
# Starts a webserver that serves the -dev directory (which is where packages
# are written by default)
#
# To make your builds use this, see vars.template
#

cd $(dirname $0)
exec python3 -m http.server -d 2020-dev 1234
