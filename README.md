# cheapstream

Brings AceStream engine to Linux ARM.

This is a build system for creating AceStream distributable
for Linux ARM target. It uses the last version of AceStream
for Android as the base with some patches. The output
distributable is suitable for running in chroot environment.

## Requirements

  - ARMv7 or newer CPU
  - systemd-enabled Linux distribution
  - systemd-nspawn for running AceStream engine in chroot-ed environment

## Usage

1. Clone the repo and build a distributable.

    ```bash
    $ git clone https://github.com/miltador/cheapstream
    $ cd cheapstream
    $ ./build.sh
    ```

2. Edit `dist/start_acestream.sh` according to your needs.
3. Run AceStream engine.
    ```bash
    $ cd dist
    $ ./start_acestream.sh
    ```