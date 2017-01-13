#!/bin/bash

#  This script will modify .bintray-deb.json for deployment on bintray 

# Ensure we're always in the right directory.
SCRIPT_DIR="$( cd "$( dirname "$0" )" && pwd )"
cd $SCRIPT_DIR/..

#Modify bintray cfg
#Use different COMPONENT to differ the apt source of release and ci-builds
VERSION=$(./extra/gen-debversion.sh)

sed -e "s/#REVERSION#/${VERSION}/g" \
    .bintray-deb.json.in > .bintray-deb.json