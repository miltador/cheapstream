#!/bin/bash

# Written by Vasiliy Solovey, 2016

ARCH=$1
BUILD_DIR="build_dir"
DIST_DIR="dist"
LATEST_ANDROID_ENGINE_URI="http://dl.acestream.org/products/acestream-engine/android/$1/latest"

echo "Cleaning up..."
rm -r $BUILD_DIR
rm -r $DIST_DIR

mkdir $BUILD_DIR
cd $BUILD_DIR

echo "Downloading latest AceStream engine for Android..."
wget $LATEST_ANDROID_ENGINE_URI -O acestream.apk

echo "Unpacking..."
unzip -q acestream.apk -d acestream_bundle

echo "Extracting resources..."
unzip -q acestream_bundle/res/raw/armeabiv7a_private_py.zip -d acestream_engine
unzip -q acestream_bundle/res/raw/armeabiv7a_private_res.zip -d acestream_engine
unzip -q acestream_bundle/res/raw/public_res.zip -d acestream_engine

echo "Patching Python..."
unzip -q acestream_engine/python/lib/python27.zip -d python27
cp -f ../mods/python27/android.py python27/

echo "Patching AceStream engine..."
cp -f ../mods/acestreamengine/main.py acestream_engine/
chmod +x acestream_engine/python/bin/python

echo "Bundling Python..."
cd python27
zip -q -r python27.zip *
mv -f python27.zip ../acestream_engine/python/lib/
cd ..

echo "Making distributable..."
cd ..
mkdir $DIST_DIR
mkdir $DIST_DIR/androidfs
cp -r chroot/* $DIST_DIR/androidfs/
cp -r -f platform/$1/* $DIST_DIR/androidfs/
cp scripts/*.sh $DIST_DIR/
mv $BUILD_DIR/acestream_engine/* $DIST_DIR/androidfs/system/data/data/org.acestream.media/files/
echo "Done!"