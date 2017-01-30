#! /usr/bin/env python
#
# Create Packages and Packages.filelist from .ipk files
#
#  Copyright (C) 2014 Peter Johnson
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions
# are met:
# 1. Redistributions of source code must retain the above copyright
#    notice, this list of conditions and the following disclaimer.
# 2. Redistributions in binary form must reproduce the above copyright
#    notice, this list of conditions and the following disclaimer in the
#    documentation and/or other materials provided with the distribution.
#
# THIS SOFTWARE IS PROVIDED BY THE AUTHOR AND OTHER CONTRIBUTORS ``AS IS''
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
# ARE DISCLAIMED.  IN NO EVENT SHALL THE AUTHOR OR OTHER CONTRIBUTORS BE
# LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
# CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
# SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
# INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
# CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
# ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
# POSSIBILITY OF SUCH DAMAGE.

import glob
import gzip
from os.path import join
import sys

import jinja2

import ipkg


def main():
    packages = ipkg.IPackageList()
    files = ipkg.IPackageFileList()

    for fn in glob.glob("*.ipk"):
        print(fn)
        ipk = ipkg.IPackage(filename=fn)
        packages.add_ipk(ipk)
        files.add_ipk(ipk)

    with open("Packages", "wt") as f:
        packages.write_list(f)

    with gzip.open("Packages.gz", "wt") as f:
        packages.write_list(f)

    with open("Packages.filelist", "wt") as f:
        files.write_list(f)
        
    # Render an index.html
    vars = {
        'title': sys.argv[1],
        'packages': [control for _, control in sorted(packages.packages.items())]
    }
        
    with open(join('tools', 'index-tmpl.html')) as f:
        template = jinja2.Template(f.read())
        
    with open("index.html", "wt") as f:
        f.write(template.render(**vars))

if __name__ == "__main__":
    main()
