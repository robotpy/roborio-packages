#
# IPK package format core functions
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

import arpy
import os
import tarfile

class IPackageControl(object):
    """IPackage control data."""

    def __init__(self, filename=None, fileobj=None, string=None):
        if string is None:
            if fileobj is None:
                fileobj = open(filename, "rt")
            string = fileobj.read().decode()
        self._control = {}
        desc = None
        for l in string.split("\n"):
            if desc is not None:
                if l[0] == " ":
                    # extended description
                    desc.append(l)
                    continue
                # end of the description
                self._control["Description"] = "\n".join(desc)
                desc = None

            if not l:
                continue
            field, val = l.split(": ")
            if field == "Description":
                desc = [val]
            else:
                self._control[field] = val

        self._control = dict(l.split(": ") for l in string.split("\n")
                             if l.strip())

    def __getattribute__(self, name):
        # All control attributes start with a capital letter
        if name[0] not in "ABCDEFGHIJKLMNOPQRSTUVWXYZ":
            return object.__getattribute__(self, name)
        _control = object.__getattribute__(self, "_control")

        # Generate standard filename if not already specified
        if name == "Filename":
            if name in _control:
                return _control[name]
            return "%s_%s_%s.ipk" % (self.Package, self.Version,
                                     self.Architecture)

        # Get attribute from control dictionary
        if name not in _control:
            raise AttributeError
        return _control[name]

    def __setattr__(self, name, value):
        # All control attributes start with a capital letter
        if name[0] not in "ABCDEFGHIJKLMNOPQRSTUVWXYZ":
            object.__setattr__(self, name, value)
            return
        _control = object.__getattribute__(self, "_control")
        _control[name] = value

    def __str__(self):
        return "\n".join("%s: %s" % x for x in self._control.items())


class IPackage(object):
    """A IPackage file."""

    def __init__(self, filename=None, fileobj=None):
        self.file = fileobj or open(filename, "rb")
        self.ar = arpy.Archive(fileobj=self.file)
        self.ar.read_all_headers()

    @property
    def control(self):
        """Return package control data."""
        if hasattr(self, "_control"):
            return self._control
        if b"control.tar.gz" not in self.ar.archived_files:
            return None
        tf = tarfile.TarFile.open(
                fileobj=self.ar.archived_files[b"control.tar.gz"],
                mode="r:gz")
        cf = tf.extractfile("control")
        self._control = IPackageControl(fileobj=cf)
        return self._control

    @property
    def md5sum(self):
        """Return MD5 checksum of package file."""
        if hasattr(self, "_md5sum"):
            return self._md5sum
        from hashlib import md5
        self.file.seek(0)
        self._md5sum = md5(self.file.read()).hexdigest()
        return self._md5sum

    @property
    def size(self):
        """Return size of package file."""
        if hasattr(self, "_size"):
            return self._size
        self.file.seek(0, os.SEEK_END)
        self._size = self.file.tell()
        return self._size

    @property
    def file_list(self):
        """Return the list of files this package installs."""
        if hasattr(self, "_file_list"):
            return self._file_list
        if b"data.tar.gz" not in self.ar.archived_files:
            return []
        tf = tarfile.TarFile.open(
                fileobj=self.ar.archived_files[b"data.tar.gz"],
                mode="r:gz")
        self._file_list = tf.getnames()
        return self._file_list


class IPackageList(object):
    """IPackage summary list.  Used for Packages.gz and the like."""

    def __init__(self):
        # IPackageControl elements, indexed by package (name, version, arch)
        self.packages = {}

    def add_list(self, filename=None, fileobj=None):
        """Add packages from a Packages or Packages.gz file"""
        if fileobj is None:
            fileobj = open(filename, "rt")
        data = fileobj.read().decode()
        for control_data in data.split("\n\n"):
            self.add_control(IPackageControl(string=control_data))

    def add_ipk(self, ipk):
        """Add an IPackage to the package list."""
        ipk.control.MD5Sum = ipk.md5sum
        ipk.control.Size = ipk.size
        self.add_control(ipk.control)

    def add_control(self, control):
        """Add a IPackageControl to the package list."""
        self.packages[(control.Package, control.Version,
                       control.Architecture)] = control

    def write_list(self, fileobj):
        """Write into file in Packages format."""
        for name, version, arch in sorted(self.packages):
            control = self.packages[(name, version, arch)]
            for field in ["Package", "Version", "Section", "Architecture",
                          "Maintainer", "MD5Sum", "Size", "Filename",
                          "Description", "OE", "Homepage", "Priority"]:
                val = getattr(control, field, "unknown")
                fileobj.write("%s: %s\n" % (field, val))
            fileobj.write("\n\n")


class IPackageFileList(object):
    """IPackage file list.  Used for Packages.filelist."""

    def __init__(self):
        # (package name, arch, full path), indexed by base filename
        self.files = {}

    def add_list(self, filename=None, fileobj=None):
        if fileobj is None:
            fileobj = open(filename, "rt")
        data = fileobj.read().decode()
        for line in data.split("\n"):
            bn, tfl = line.split(" ", 1)
            tfl = [x.split(":") for x in tfl.split(",")]
            fl = self.files.setdefault(bn, [])
            fl.extend(tfl)

    def add_ipk(self, ipk):
        """Add from IPackage."""
        for ifn in ipk.file_list:
            fl = self.files.setdefault(os.path.basename(ifn), [])
            fl.append((ipk.control.Package, ipk.control.Architecture, ifn))

    def write_list(self, fileobj):
        """Write into file in Packages.filelist format."""
        for bn in sorted(self.files):
            fileobj.write("%s %s\n" % (bn, ",".join("%s:%s:%s" % x
                                                    for x in self.files[bn])))


if __name__ == "__main__":
    import sys
    x = IPackage(sys.argv[1])
    c = x.control
    c.MD5Sum = x.md5sum
    c.Size = x.size
    print(c.Package)
    print(c)
