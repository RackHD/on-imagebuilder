#!/bin/bash

#  This script will modify .bintray-deb.json for deployment on bintray 

# Ensure we're always in the right directory.
SCRIPT_DIR="$( cd "$( dirname "$0" )" && pwd )"
cd $SCRIPT_DIR/..

#Modify bintray cfg
#Use different COMPONENT to differ the apt source of release and ci-builds
DEBBRANCH=$(./extra/gen-debbranch.sh)
if [[ $DEBBRANCH =~ ^[0-9.]+$ ]]; then
    COMPONENT=release
else
    COMPONENT=main
fi
sed -e "s/#REVERSION#/${DEBBRANCH}/g" \
    -e "s/#COMPONENT#/${COMPONENT}/g" \
    .bintray-deb.json.in > .bintray-deb.json