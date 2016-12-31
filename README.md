# cheapstream

Brings AceStream engine to Linux ARM.

This is a build system for creating AceStream distributable
for Linux ARM target. It uses the last version of AceStream
for Android as the base with some patches. The output
distributable is suitable for running in chroot environment.

## Requirements

  - ARMv7+ CPU
  - systemd-enabled Linux distribution
  - systemd-nspawn for running AceStream engine in chroot-ed environment

## Usage

1. Clone the repo and build a distributable.

    ```bash
    $ git clone https://github.com/miltador/cheapstream
    $ cd cheapstream
    $ ./build.sh [arm|x86]
    ```

2. Edit `dist/start_acestream.sh` according to your needs.
3. Run AceStream engine.

    ```bash
    $ cd dist
    $ ./start_acestream.sh
    ```

## TODO

  - Make x86 port usable (probably need to find perfect donor)
  - Revise and complete android.py RPC responses emulation
  - Set timezone for systemd container properly
  - Pack dnspython lib (`mods/python27/dns`) into an egg
  - etc... Open issues if you have any idea!

## Thanks

Special thanks to those people who made it possible by providing first ports.
