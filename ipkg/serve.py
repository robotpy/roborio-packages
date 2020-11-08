#!/usr/bin/env python3
#
# Starts a webserver that serves the -dev directory (which is where packages
# are written by default)
#
# To make your builds use this, see vars.template
#

from functools import partial
from os.path import abspath, dirname, join, relpath
from http.server import test, SimpleHTTPRequestHandler, ThreadingHTTPServer

YEAR = "2021"
ROOT = abspath(dirname(__file__))
IPK_DIR = join(ROOT, f"{YEAR}-dev")
WHL_DIR = join(ROOT, f"{YEAR}-whl")
PORT = 1234

# redirect /pypi to wheel directory
pypi_root = join(IPK_DIR, 'pypi')

class MyRequestHandler(SimpleHTTPRequestHandler):
    def translate_path(self, path):
        
        path = super().translate_path(path)
        
        if path.startswith(pypi_root):
            trailing_slash = path.endswith('/')
            path = relpath(path, pypi_root)
            path = join(WHL_DIR, path)
            if trailing_slash:
                path += '/'

        return path


if __name__ == '__main__':
    handler = partial(MyRequestHandler, directory=IPK_DIR)
    test(HandlerClass=handler, port=PORT)