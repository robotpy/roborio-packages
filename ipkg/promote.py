#!/usr/bin/env python

import glob
from os.path import basename, dirname, exists, join
import shutil

import click

ROOT = dirname(__file__)
DEVROOT = join(ROOT, '2018-dev')
PRODROOT = join(ROOT, '2018')

@click.group()
def cli():
    pass

@cli.command(name='list')
def _list():
    for fn in sorted(glob.glob(join(DEVROOT, '*.ipk'))):
        fn = basename(fn)
        name, version, arch = fn.split('_')

        if exists(join(PRODROOT, fn)):
            print('OK:', name, version)
        else:
            print("--:", name, version)


@cli.command()
@click.argument('package')
@click.argument('version')
@click.option('-f', '--force', default=False)
def promote(package, version, force):
    fname = '%s_%s_cortexa9-vfpv3.ipk' % (package, version)
    srcpath = join(DEVROOT, fname)
    dstpath = join(PRODROOT, fname)

    if exists(dstpath) and not force:
        raise click.Abort("%s already exists" % dstpath)

    # TODO: check dependencies?

    print(srcpath, ' -> ', dstpath)
    shutil.copyfile(srcpath, dstpath)


if __name__ == '__main__':
    cli()
