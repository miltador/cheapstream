#!/system/bin/sh

export ANDROID_ROOT=/system
export ANDROID_DATA=/data
export ANDROID_STORAGE=/storage
export PYTHONHOME=/data/data/org.acestream.media/files/python
export PYTHONPATH=/data/data/org.acestream.media/files/python/lib/python2.7/lib-dynload:/data/data/org.acestream.media/files/python/lib/python2.7
export PATH=$PYTHONHOME/bin:$PATH
export LD_LIBRARY_PATH=/data/data/org.acestream.media/files/python/lib:/data/data/org.acestream.media/files/python/lib/python2.7/lib-dynload
cd /data/data/org.acestream.media/files/
python main.py "$@"
