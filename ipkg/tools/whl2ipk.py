#!/usr/bin/env python3
#
# Copyright (C) 2017 Dustin Spicuzza
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

import argparse
import contextlib
import json
import inspect
from io import BytesIO
import os
from os.path import abspath, exists, join
import re
import shutil
import subprocess
import sys
import tarfile
import tempfile

from wheel.install import WheelFile


@contextlib.contextmanager
def chdir(p):
    oldcwd = os.getcwd()
    os.chdir(p)
    try:
        yield
    finally:
        os.chdir(oldcwd)


class WheelConverter:
    '''
        Not super flexible, nor does it currently validate that the wheel
        architecture actually matches.. but hey, it works for what I need
        it for. :)
    '''
    
    def __init__(self, whl_path, pkgname,
                       python_version, maintainer,
                       arch, depends,
                       prefix):
        self.whl = WheelFile(whl_path)
        self.pyname = self.whl.parsed_filename.group('name')
        self.pkgname = pkgname if pkgname else self.pyname
        
        self.py = 'python%s' % python_version
        
        self.paths = {
            'purelib': join(prefix, 'lib', self.py, 'site-packages'),
            'platlib': join(prefix, 'lib', self.py, 'site-packages'),
            'headers': join(prefix, 'include', self.py + 'm', self.pyname),
            'scripts': join(prefix, 'bin'),
            'data':    prefix,
        }
        
        self.executable = join(prefix, 'bin', self.py)
        
        self.maintainer = maintainer
        self.arch = arch
        self.depends = depends
    
    def create_control(self, output_fname):
        '''
            Creates the control scripts
        '''
        
        # read the metadata
        metadata_fname = '%s/metadata.json' % self.whl.distinfo_name
        metadata = json.loads(self.whl.zipfile.read(metadata_fname).decode('utf-8'))
        
        # Create the control file contents
        control = []
        control.append('Package: %s' % self.pkgname)
        control.append('Version: %s' % metadata['version'])
        control.append('Description: %s' % metadata.get('summary', 'Unknown'))
        control.append('Section: devel')
        control.append('Priority: optional')
        control.append('Maintainer: %s' % self.maintainer)
        
        if 'license' in metadata:
            control.append('License: %s' % metadata['license'])
            
        control.append('Architecture: %s' % self.arch)
        if self.depends:
            control.append('Depends: %s' % self.depends)
        
        control.append('Source: https://pypi.python.org/pypi/%s/%s' % (self.pyname, metadata['version']))
    
        # Create the post-install script to create all pyc files
        postinst = inspect.cleandoc('''
            #!%(scripts)s/%(py)s

            import compileall
            import csv
            
            sp = '%(purelib)s/'
            
            with open(sp + '%(record)s') as fp:
              for row in csv.reader(fp):
                compileall.compile_file(sp + row[0], quiet=1)
        ''')
        
        postinst %= {
            'py': self.py,
            'purelib': self.paths['purelib'],
            'record': self.whl.record_name,
            'scripts': self.paths['scripts'],
        }
        
        # Write the tarfile
        with tarfile.open(output_fname, 'w|gz') as tfp:
            
            def _add(fname, contents, mode):
                info = tarfile.TarInfo(fname)
                info.size = len(contents)
                info.mode = mode
                info.gid = 0
                info.uid = 0
                tfp.addfile(info, BytesIO(contents.encode('utf-8')))
          
            _add('control',
                 '\n'.join(control) + '\n',
                 0o644)
            
            # Add a postinst script to compile the pyc files
            _add('postinst',
                 postinst,
                 0o755)

            # Use a prerm script to remove all pyc files
            _add('prerm',
                 '#!/bin/bash\npip3 --disable-pip-version-check uninstall -y %s\n' % metadata['name'],
                 0o755)
    
    def create_data(self, datadir, output_fname):
        '''
            Extracts a wheel and tars it up
        '''
        
        # Tell wheel to do an 'install' to the output directory
        overrides = {k: datadir + v for k, v in self.paths.items()}
        
        # Need to give it the location of the executable so that
        # scripts are written correctly
        tmp = sys.executable
        sys.executable = self.executable
        
        try:
            self.whl.install(overrides=overrides)
        finally:
            sys.executable = tmp
    
        output_fname = abspath(output_fname)
    
        with chdir(datadir):
            subprocess.check_call('tar -czvf "%s" --owner=0 --group=0 .' % output_fname, shell=True)
    
    def create_ipk(self, output_file):
        '''Does all the necessary steps'''
        
        tmpdir = tempfile.mkdtemp()
        
        try:
            self.create_control(join(tmpdir, 'control.tar.gz'))
            self.create_data(join(tmpdir, 'data'), join(tmpdir, 'data.tar.gz'))
            
            with open(join(tmpdir, 'debian-binary'), 'w') as fp:
                fp.write('2.0')
            
            with chdir(tmpdir):
                subprocess.check_call('ar r ipk control.tar.gz data.tar.gz debian-binary', shell=True)
            
            shutil.move(join(tmpdir, 'ipk'), output_file)
            print(output_file, 'created')
            
        finally:
            shutil.rmtree(tmpdir)
    
def _check_version(v):
    if not re.match(r'\d\.\d', v):
        raise argparse.ArgumentTypeError("Version must be in form 'x.y'")
    return v
        

def main():
    
    # Arguments are meant to be passed by a common script
    # Config file is per-wheel configuration
    
    p = argparse.ArgumentParser()
    p.add_argument('whl_path')
    p.add_argument('output_ipk')
    p.add_argument('--py', type=_check_version, required=True)    
    p.add_argument('--maintainer', required=True)
    p.add_argument('--arch', required=True)
    p.add_argument('--prefix', default='/usr/local')
    p.add_argument('--depends', action='append', default=[])
    p.add_argument('--pkgname')
    
    args = p.parse_args()
    
    w = WheelConverter(args.whl_path, args.pkgname,
                       args.py, args.maintainer,
                       args.arch, ', '.join(args.depends),
                       args.prefix)
    
    w.create_ipk(args.output_ipk)
    
if __name__ == '__main__':
    main()
