#!/bin/bash
set -ex

#
# This script will generate var DEBRANCH
# DEBRANCH format is ${SYMBOL}-${DATESTRING}
#

DEBDIR="./debian"
if [ ! -d "${DEBDIR}" ]; then
    echo "Debian directory ${DEBDIR} doesn't exist"
    exit 1
fi

# Version in changelog will be assigned when branch created
# The version in pushed tag will be exactly the same with that in changelog
VERSION=$(dpkg-parsechangelog | grep ^Version | cut -d' ' -f2 | cut -d' ' -f1) 
GIT_COMMIT_DATE=$(git show -s --pretty="format:%ci")
DATE_STRING=$(date -d "$GIT_COMMIT_DATE" -u +"%Y%m%dUTC")
GIT_COMMIT_HASH=$(git show -s --pretty="format:%h")
if [ -z "$DEBVERSION" ]; then
    DEBVERSION=${VERSION}-${DATE_STRING}-${GIT_COMMIT_HASH}
fi
echo $DEBVERSION
