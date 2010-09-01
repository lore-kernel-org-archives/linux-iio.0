Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 0/9] Trivial fixes
Date: Wed,  1 Sep 2010 15:57:54 +0100
Message-Id: <1283353083-31313-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Hi All,

This is a pretty simple clean up set.  Mostly removes
some dead code in various places and cleans up the documentation
somewhat.

Please take a quick look.

Jonathan

Jonathan Cameron (9):
  staging:iio: convert idr to ida as pointer never provided
  staging:iio: simplify logic in iio_interrupt_handler
  staging:iio: unecessary header removal and kernel doc clean up
  staging:iio: Remove long dead function definitions from headers
  staging:iio: Remove deprecated ATTR_TEMP in favour of ATTR_TEMP_RAW
  staging:iio: Make use of the convenient IIO_TRIGGER_NAME_ATTR macro
  staging:iio: remove odd structure definition.
  staging:iio: lis3l02dqbuffersimple.c bring example up to date.
  staging:iio:documentation - partial update to make more of it true.

 .../iio/Documentation/lis3l02dqbuffersimple.c      |    4 +-
 drivers/staging/iio/Documentation/overview.txt     |   17 ++--
 .../{sysfs-class-iio => sysfs-bus-iio}             |    0
 drivers/staging/iio/Documentation/userspace.txt    |   54 +------------
 drivers/staging/iio/accel/adis16209_core.c         |    4 +-
 drivers/staging/iio/accel/adis16209_trigger.c      |    2 +-
 drivers/staging/iio/accel/adis16240_trigger.c      |    2 +-
 drivers/staging/iio/accel/lis3l02dq_ring.c         |    3 +-
 drivers/staging/iio/chrdev.h                       |    2 -
 drivers/staging/iio/gyro/adis16260_trigger.c       |    2 +-
 drivers/staging/iio/iio.h                          |    8 +-
 drivers/staging/iio/imu/adis16300_trigger.c        |    2 +-
 drivers/staging/iio/imu/adis16350_trigger.c        |    2 +-
 drivers/staging/iio/imu/adis16400_trigger.c        |    2 +-
 drivers/staging/iio/industrialio-core.c            |   76 ++++++++----------
 drivers/staging/iio/industrialio-ring.c            |   11 +--
 drivers/staging/iio/ring_generic.h                 |   69 ++++++++++++++--
 drivers/staging/iio/sysfs.h                        |   83 --------------------
 drivers/staging/iio/trigger.h                      |    6 +-
 drivers/staging/iio/trigger/iio-trig-gpio.c        |    2 +-
 .../staging/iio/trigger/iio-trig-periodic-rtc.c    |   12 +---
 21 files changed, 127 insertions(+), 236 deletions(-)
 rename drivers/staging/iio/Documentation/{sysfs-class-iio => sysfs-bus-iio} (100%)
