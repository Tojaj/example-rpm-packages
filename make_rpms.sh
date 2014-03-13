#!/bin/bash

set -e  # Fail on first error

SCRIPTDIR="$( cd "$(dirname "$0")" ; pwd -P )"
source "$SCRIPTDIR"/enabled_packages.sh

PACKAGESDIR="$SCRIPTDIR/PACKAGES"
RPMBUILD_DIR="${HOME}/rpmbuild"
BUILD_DIR="$RPMBUILD_DIR/BUILD"

echo "Stage 0 - Preparing PACKAGES directory"
rm -rf "$PACKAGESDIR"
mkdir "$PACKAGESDIR"

echo "Stage 1 - Building tarballs ..."
"$SCRIPTDIR/make_tarballs.sh"

echo "Stage 2 - Building packages ..."
for DIR in "${PACKAGES[@]}"
do
    DIR="$SCRIPTDIR/$DIR"
    pushd "$DIR" > /dev/null
    PKGNAME=$( basename `pwd` )
    TARBALL="$PKGNAME.tar.xz"
    echo "Generating $TARBALL ..."
    echo "Cleaning $BUILD_DIR"
    rm -rf "$BUILD_DIR"
    echo "Removing $RPMBUILD_DIR/$PKGNAME.spec"
    rm -f "$RPMBUILD_DIR/$PKGNAME.spec"
    echo "Copying tarball and .spec file into the $RPMBUILD_DIR"
    cp "$TARBALL" "$RPMBUILD_DIR/SOURCES/"
    cp "$PKGNAME.spec" "$RPMBUILD_DIR/SPECS/"
    echo "Cleaning $RPMBUILD_DIR/RPMS/"
    rm -rf "$RPMBUILD_DIR/RPMS/*"
    echo "Building ..."
    rpmbuild -ba "$RPMBUILD_DIR/SPECS/$PKGNAME.spec" | tee "$PACKAGESDIR/$PKGNAME-build.log"
    echo "Clean up ..."
    rpmbuild --clean "$RPMBUILD_DIR/SPECS/$PKGNAME.spec"
    echo "Copying rpm packages ..."
    mv --verbose "$RPMBUILD_DIR"/SRPMS/"$PKGNAME"-*.src.rpm "$PACKAGESDIR/"
    mv --verbose "$RPMBUILD_DIR"/RPMS/*/*.rpm "$PACKAGESDIR/"
    popd > /dev/null
done
