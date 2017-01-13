#!/bin/bash
set -ex

# Ensure we're always in the right directory.
SCRIPT_DIR="$( cd "$( dirname "$0" )" && pwd )"
cd $SCRIPT_DIR/..
output_path=/tmp/on-imagebuilder

# this appends a datestring formatting specifically to be increasing
# based on the last date of the commit in this branch to provide increasing
# DCH version numbers for building debian packages for bintray.
if [ -z "$DEBFULLNAME" ]; then
        export DEBFULLNAME=`git log -n 1 --pretty=format:%an`
fi

if [ -z "$DEBEMAIL" ]; then
        export DEBEMAIL=`git log -n 1 --pretty=format:%ae`
fi

if [ -z "$DEBVERSION" ]; then
        export DEBVERSION=$(./extra/gen-debversion.sh)
fi

if [ -z "$DEBPKGVER" ]; then
        export DEBPKGVER=`git log -n 1 --pretty=oneline --abbrev-commit`
fi

if [ -z "$DCHOPTS" ]; then
        export DCHOPTS="-v ${DEBVERSION} -u low ${DEBPKGVER} -b -m"
fi

echo "DEBDIR:       $DEBDIR"
echo "DEBFULLNAME:  $DEBFULLNAME"
echo "DEBEMAIL:     $DEBEMAIL"
echo "DEBVERSION:   $DEBVERSION"
echo "DEBPKGVER:    $DEBPKGVER"
echo "DCHOPTS:      $DCHOPTS"


if [ -d packagebuild ]; then
  rm -rf packagebuild
fi
mkdir packagebuild
pushd packagebuild
rsync -av ../debian .
mkdir common
mkdir pxe
sudo cp $output_path/builds/* common/
sudo cp $output_path/syslinux/* pxe/
sudo cp $output_path/ipxe/* pxe/
git log -n 1 --pretty=format:%h.%ai.%s > commitstring.txt
dch ${DCHOPTS}
debuild --no-lintian --no-tgz-check -us -uc
popd
if [ ! -d deb ]; then
  mkdir deb
fi

cp -a *.deb deb/
