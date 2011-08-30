Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: greg@kroah.com
Cc: linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 00/14] staging:iio:cleanups and bug fixes.
Date: Tue, 30 Aug 2011 12:41:05 +0100
Message-Id: <1314704479-15956-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Hi Greg,

Sits on top of staging:iio: character device merge

Another round of cleanups (mostly) and a few fixes due to
incorrect ordering of bits and bobs in the remove functions.

Pretty trivial bunch all in all. Been on list since last
week in this form.

Thanks,

Jonathan

Original text:

This set sits on top of the chrdev unifying set.

Not much in the way of controversial stuff here.

Patches 1, 3, 4, 9 remove stuff that isn't needed
Patch 2 makes use of the ida_simple stuff of Rusty Russell
Patches 5, 6, 7, 8, 10, 11, 13 are conventional cleanups.
Patch 12 is a set of free then use bug fixes thrown up during
the attribute registration rework ithat will follow shortly.

Please shout fairly quicly if you have issues with any of these as
I'd like to push them out soon.

Thanks,

Jonathan



Jonathan Cameron (13):
  staging:iio: remove broken support for multiple event interfaces.
  staging:iio: use ida_simple_get and ida_simple_remove + merge ids
  staging:iio: remove defunct iio_put and iio_get.
  staging:iio: remove orphaned function definition.
  staging:iio:trivial add a string array for IIO_RAW and IIO_PROCESSED.
  staging:iio: struct iio_dev formatting cleanup and documentation
    fixes.
  staging:iio:buffering drag some stray docs back to correct place.
  staging:iio:buffering cleanup ring_buffer_register_ex naming.
  staging:iio: push "sysfs.h" and linux/irq.h out of iio.h
  staging:iio:light:tsl2563 remove use of IIO_CHAN macro and make use
    modifier defines.
  staging:iio:light:tsl2563 remove unused headers.
  staging:iio:fix using iio_priv or iio_dev after iio_unregister_device
  staging:iio:various cleanup regulator use paths.

Michael Hennerich (1):
  staging:iio: fix typo

 drivers/staging/iio/accel/adis16201_core.c      |    8 +-
 drivers/staging/iio/accel/adis16203_core.c      |    8 +-
 drivers/staging/iio/accel/adis16204_core.c      |    8 +-
 drivers/staging/iio/accel/adis16209_core.c      |    8 +-
 drivers/staging/iio/accel/adis16240_core.c      |    8 +-
 drivers/staging/iio/accel/lis3l02dq_core.c      |   19 +-
 drivers/staging/iio/accel/sca3000_core.c        |   15 +-
 drivers/staging/iio/adc/ad7150.c                |   21 +-
 drivers/staging/iio/adc/ad7192.c                |    6 +-
 drivers/staging/iio/adc/ad7280a.c               |    9 +-
 drivers/staging/iio/adc/ad7291.c                |   14 +-
 drivers/staging/iio/adc/ad7298_core.c           |    6 +-
 drivers/staging/iio/adc/ad7314.c                |    1 -
 drivers/staging/iio/adc/ad7476_core.c           |   32 ++--
 drivers/staging/iio/adc/ad7606_core.c           |    6 +-
 drivers/staging/iio/adc/ad7745.c                |    5 +-
 drivers/staging/iio/adc/ad7793.c                |    6 +-
 drivers/staging/iio/adc/ad7816.c                |    6 +-
 drivers/staging/iio/adc/ad7887_core.c           |    6 +-
 drivers/staging/iio/adc/ad799x_core.c           |   10 +-
 drivers/staging/iio/adc/adt7310.c               |    8 +-
 drivers/staging/iio/adc/adt7410.c               |    7 +-
 drivers/staging/iio/adc/adt75.c                 |    4 +-
 drivers/staging/iio/adc/max1363_core.c          |   10 +-
 drivers/staging/iio/addac/adt7316.c             |   19 +-
 drivers/staging/iio/dac/ad5504.c                |    4 +-
 drivers/staging/iio/dac/ad5624r_spi.c           |   53 ++---
 drivers/staging/iio/dac/ad5686.c                |    7 +-
 drivers/staging/iio/dac/ad5791.c                |   74 +++----
 drivers/staging/iio/dac/max517.c                |    1 +
 drivers/staging/iio/gyro/adis16260_core.c       |    8 +-
 drivers/staging/iio/iio.h                       |   35 ++--
 drivers/staging/iio/iio_core.h                  |   12 +-
 drivers/staging/iio/impedance-analyzer/ad5933.c |    2 +-
 drivers/staging/iio/imu/adis16400_core.c        |    6 +-
 drivers/staging/iio/industrialio-core.c         |  285 ++++++++---------------
 drivers/staging/iio/industrialio-ring.c         |    9 +-
 drivers/staging/iio/industrialio-trigger.c      |   50 +----
 drivers/staging/iio/light/isl29018.c            |    2 +-
 drivers/staging/iio/light/tsl2563.c             |   34 ++-
 drivers/staging/iio/magnetometer/ak8975.c       |    3 +-
 drivers/staging/iio/meter/ade7758_core.c        |    6 +-
 drivers/staging/iio/resolver/ad2s1210.c         |    2 +-
 drivers/staging/iio/ring_generic.h              |   29 ++--
 44 files changed, 359 insertions(+), 513 deletions(-)

-- 
1.7.3.4
