#!/bin/bash

SCRIPTDIR="$( cd "$(dirname "$0")" ; pwd -P )"
source "$SCRIPTDIR"/enabled_packages.sh

for DIR in "${PACKAGES[@]}"
do
    DIR="$SCRIPTDIR/$DIR"
    pushd "$DIR" > /dev/null
    PKGNAME=$( basename `pwd` )
    TARBALL="$PKGNAME.tar.xz"
    echo "Generating $TARBALL ..."
    rm -rf "$TARBALL"
    git archive HEAD --prefix="$PKGNAME/" | xz > "$TARBALL"
    popd > /dev/null
done
