#!/usr/bin/env python

import glob
from os.path import basename, dirname, exists, join
import shutil

import click

ROOT = dirname(__file__)
DEVROOT = join(ROOT, "2022-dev")
PRODROOT = join(ROOT, "2022")


def _plist(quiet=False):
    idx = -1
    for fn in sorted(glob.glob(join(DEVROOT, "*.ipk"))):
        idx += 1
        fn = basename(fn)
        name, version, arch = fn.split("_")

        yield name, version

        if exists(join(PRODROOT, fn)):
            if not quiet:
                print(idx, "OK:", name, version)
        else:
            print(idx, "--:", name, version)


@click.group()
def cli():
    pass


@cli.command(name="list")
def _list():
    list(_plist())


@cli.command()
@click.option("-q", "--quiet", is_flag=True, default=False)
def plist(quiet):
    while True:
        print("---")
        l = list(_plist(quiet))
        print("---")
        idx = input("Which? ")
        try:
            idx = int(idx)
        except ValueError:
            break

        _promote(*l[idx])


@cli.command()
@click.argument("package")
@click.argument("version")
@click.option("-f", "--force", default=False)
def promote(package, version, force):
    _promote(package, version, force)


def _promote(package, version, force=False):
    fname = "%s_%s_cortexa9-vfpv3.ipk" % (package, version)
    srcpath = join(DEVROOT, fname)
    dstpath = join(PRODROOT, fname)

    if exists(dstpath) and not force:
        raise click.Abort("%s already exists" % dstpath)

    # TODO: check dependencies?

    print(srcpath, " -> ", dstpath)
    shutil.copyfile(srcpath, dstpath)


if __name__ == "__main__":
    cli()
