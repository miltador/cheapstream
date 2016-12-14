#!/bin/bash

# Written by Vasiliy Solovey, 2016

BUILD_DIR="build_dir"
DIST_DIR="dist"
LATEST_ANDROID_ENGINE_URI="http://dl.acestream.org/products/acestream-engine/android/armv7/latest"

echo "Cleaning up..."
rm -r $BUILD_DIR
rm -r $DIST_DIR

mkdir $BUILD_DIR
cd $BUILD_DIR

echo "Downloading latest AceStream engine for Android..."
wget $LATEST_ANDROID_ENGINE_URI -q -O acestream.apk

echo "Unpacking..."
unzip -q acestream.apk -d acestream_bundle

echo "Extracting resources..."
unzip -q acestream_bundle/res/raw/armeabiv7a_private_py.zip -d acestream_engine
unzip -q acestream_bundle/res/raw/armeabiv7a_private_res.zip -d acestream_engine
unzip -q acestream_bundle/res/raw/public_res.zip -d acestream_engine

echo "Patching Python..."
unzip -q acestream_engine/python/lib/python27.zip -d python27
patch python27/android.py < ../patches/python27/001-android.py-missing-methods.patch

echo "Patching AceStream engine..."
patch acestream_engine/main.py < ../patches/acestreamengine/001-main.py.patch
chmod +x acestream_engine/python/bin/python

echo "Bundling Python..."
zip -q -r python27.zip python27/*
mv -f python27.zip acestream_engine/python/lib/

echo "Making distributable..."
mkdir ../$DIST_DIR
cp -R ../androidfs/ ../$DIST_DIR/
cp ../scripts/*.sh ../$DIST_DIR/
mv acestream_engine/* ../$DIST_DIR/androidfs/system/data/data/org.acestream.engine/files/