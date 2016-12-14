#!/system/bin/sh

export ANDROID_ROOT=/sdcard
export PYTHONHOME=/system/data/data/org.acestream.media/files/python
export PYTHONPATH=/system/data/data/org.acestream.media/files/python/lib/python2.7/lib-dynload:/system/data/data/org.acestream.media/files/python/lib/python2.7
export PATH=$PYTHONHOME/bin:$PATH
export LD_LIBRARY_PATH=/system/data/data/org.acestream.media/files/python/lib:/system/data/data/org.acestream.media/files/python/lib/python2.7/lib-dynload
cd /system/data/data/org.acestream.media/files/
/system/data/data/org.acestream.media/files/python/bin/python /system/data/data/org.acestream.media/files/main.py "$@"