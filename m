Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: gregkh@suse.de
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 00/20] staging:iio updates Abi changes and new drivers
Date: Tue,  4 May 2010 14:42:55 +0100
Message-Id: <1272980595-11033-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Dear Greg,

The following set is based upon your staging-next tree as of Sunday.
When the caching updates they should be available on:

git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio-new-abi.git master

so if it is easier for you, pull from there.

The two Analog devices drivers are from the blackfin tree (where numerous
other iio drivers exist). 
git://sources.blackfin.uclinux.org/git/readonly-mirrors/linux-kernel.git

For Barry, I fixed up a couple of dependency issues in imu/Kconfig whilst
merging your drivers.

Minor changes were made to get them to work with the abi changes.  An
incremental patch will follow to fix remaining non conforming abi elements.

The rest are, up to a few typo and merge related fixes, as per V2 posted
widely so this set isn't going to lkml this time round.

I'm guessing everyone who is developing iio drivers is actually on linux-iio.
This will break your drivers if they aren't in mainline, but only in easily
fixed ways (I hope!)

Jonathan


Barry Song (2):
  staging:iio:imu ADIS16300 driver
  staging:iio:imu ADIS16400 and ADIS16405 driver

Jonathan Cameron (18):
  staging:iio: Add new in_raw definitions for adc channels.
  staging:iio: Add new attrs for sampling frequency available and
    temp_raw
  iio:staging:accelerometers move towards the new abi
  staging:iio: Support functions for scan mask matching
  staging: iio: Move from class to bus
  staging:iio: Move event attributes into the event[n] device in sysfs
  staging:iio: Clean out unused IIO_SCAN_EL and add IIO_SCAN_NAMED_EL_C
  staging:iio:max1363 move to new abi.
  staging:iio: Documentation, update iio_utils.h for the move to a bus
  staging:iio: ABI documentation (partial)
  staging:iio: Directory name changes to match new ABI.
  staging:iio:tsl2563: change lux to illuminance0_input to match new
    abi
  staging:iio: Remove naming via IDR's where no longer necessary under
    new abi.
  staging:iio:max1363 add support for max11606-max11617
  staging:iio:max1363 add support for 8 bit equivalent devices,
    max1036-9, max11600-5
  staging:iio:ring_sw: Fix incorrect test on successful read of last
    value, causes infinite loop
  staging:iio:tsl2563 add a name attribute under the iio
  staging:iio:Documentation: Rewrite example for new abi.

 drivers/staging/iio/Documentation/iio_utils.h      |  266 +++--
 .../iio/Documentation/lis3l02dqbuffersimple.c      |  234 +++--
 drivers/staging/iio/Documentation/sysfs-class-iio  |  285 +++++
 drivers/staging/iio/Kconfig                        |    1 +
 drivers/staging/iio/Makefile                       |    1 +
 drivers/staging/iio/accel/accel.h                  |    8 +-
 drivers/staging/iio/accel/kxsd9.c                  |   88 +-
 drivers/staging/iio/accel/lis3l02dq.h              |    4 -
 drivers/staging/iio/accel/lis3l02dq_core.c         |  175 ++--
 drivers/staging/iio/accel/lis3l02dq_ring.c         |   10 +-
 drivers/staging/iio/accel/sca3000.h                |    2 +
 drivers/staging/iio/accel/sca3000_core.c           |  174 ++--
 drivers/staging/iio/accel/sca3000_ring.c           |   33 +-
 drivers/staging/iio/adc/Kconfig                    |   11 +-
 drivers/staging/iio/adc/Makefile                   |    2 +-
 drivers/staging/iio/adc/adc.h                      |   15 +
 drivers/staging/iio/adc/max1363.h                  |  122 +--
 drivers/staging/iio/adc/max1363_core.c             | 1109 ++++++++++++++------
 drivers/staging/iio/adc/max1363_ring.c             |   80 +-
 drivers/staging/iio/chrdev.h                       |    2 +-
 drivers/staging/iio/gyro/gyro.h                    |   76 ++
 drivers/staging/iio/iio.h                          |   47 +-
 drivers/staging/iio/imu/Kconfig                    |   24 +
 drivers/staging/iio/imu/Makefile                   |   10 +
 drivers/staging/iio/imu/adis16300.h                |  203 ++++
 drivers/staging/iio/imu/adis16300_core.c           |  833 +++++++++++++++
 drivers/staging/iio/imu/adis16300_ring.c           |  233 ++++
 drivers/staging/iio/imu/adis16300_trigger.c        |  127 +++
 drivers/staging/iio/imu/adis16400.h                |  238 +++++
 drivers/staging/iio/imu/adis16400_core.c           |  849 +++++++++++++++
 drivers/staging/iio/imu/adis16400_ring.c           |  245 +++++
 drivers/staging/iio/imu/adis16400_trigger.c        |  127 +++
 drivers/staging/iio/industrialio-core.c            |   58 +-
 drivers/staging/iio/industrialio-ring.c            |   63 +-
 drivers/staging/iio/industrialio-trigger.c         |    2 +-
 drivers/staging/iio/light/tsl2563.c                |   16 +-
 drivers/staging/iio/magnetometer/magnet.h          |   31 +
 drivers/staging/iio/ring_generic.h                 |   42 +-
 drivers/staging/iio/ring_sw.c                      |    4 +-
 drivers/staging/iio/sysfs.h                        |   15 +-
 40 files changed, 4936 insertions(+), 929 deletions(-)
 create mode 100644 drivers/staging/iio/Documentation/sysfs-class-iio
 create mode 100644 drivers/staging/iio/gyro/gyro.h
 create mode 100644 drivers/staging/iio/imu/Kconfig
 create mode 100644 drivers/staging/iio/imu/Makefile
 create mode 100644 drivers/staging/iio/imu/adis16300.h
 create mode 100644 drivers/staging/iio/imu/adis16300_core.c
 create mode 100644 drivers/staging/iio/imu/adis16300_ring.c
 create mode 100644 drivers/staging/iio/imu/adis16300_trigger.c
 create mode 100644 drivers/staging/iio/imu/adis16400.h
 create mode 100644 drivers/staging/iio/imu/adis16400_core.c
 create mode 100644 drivers/staging/iio/imu/adis16400_ring.c
 create mode 100644 drivers/staging/iio/imu/adis16400_trigger.c
 create mode 100644 drivers/staging/iio/magnetometer/magnet.h
