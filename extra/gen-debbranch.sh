#!/bin/bash
set -ex

#
# This script will generate var DEBRANCH
# DEBRANCH format is ${SYMBOL}-${DATESTRING}
#

DEBDIR="./debian"
if [ ! -d "${DEBDIR}" ]; then
    echo "no such debian directory ${DEBDIR}"
    exit 1
fi

# Use the TRAVIS_BRANCH var if defined as 
# travis vm doesn't run the git symbolic-ref command.
if [ -n "$TRAVIS_BRANCH" ]; then
   BRANCH=${TRAVIS_BRANCH}
else
   BRANCH=$(git symbolic-ref --short -q HEAD)
fi

#Generate SYMBOL according to branch or tag
if [[ "${BRANCH}" == *"master"* ]]; then
   SYMBOL=devel
elif [[ "${BRANCH}" == *"release"* ]]; then
   SYMBOL=rc
fi

#When a tag like "release-1.2.3" is pushed, do release
if [ -n "$TRAVIS_TAG" ] && [[ "$TRAVIS_TAG" =~ ^release\/([0-9.]+) ]]; then
   SYMBOL=release
fi

#Generate var DEBBRANCH
#Version in changelog will be assigned when branch created
#The version in pushed tag will be exactly the same with that in changelog
VERSION=$(dpkg-parsechangelog | grep ^Version | cut -d' ' -f2 | cut -d'-' -f1)
GITCOMMITDATE=$(git show -s --pretty="format:%ci")
DATESTRING=$(date -d "$GITCOMMITDATE" -u +"%Y%m%d%H%M%SZ")
HASH=$(git rev-parse --short HEAD)
if [ -z "$DEBBRANCH" ]; then
    if [ "$SYMBOL" != "release" ]; then
        DEBBRANCH=`echo "${VERSION}~${SYMBOL}-${DATESTRING}-${HASH}" | sed 's/[\/\_]/-/g'`
    else
        DEBBRANCH=`echo "${VERSION}" | sed 's/[\/\_]/-/g'`
    fi
fi
echo $DEBBRANCH