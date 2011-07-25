Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 0/2] blue part 4: IIO general cleanup
Date: Mon, 25 Jul 2011 14:10:50 +0100
Message-Id: <1311599458-15152-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Nothing overwhelming in here, but all sensible (I think) bits and bobs.

Some are necessary precursors for following series, but not explicitly
relevant to them.

Thanks,

Jonathan

Jonathan Cameron (8):
  staging:iio:core flatten convenience function that only has one user.
  staging:iio:core squash trivial wrappers and use ida allocation func.
  staging:iio:trigger core. Trivial code cleanups.
  staging:iio: Introduce iio_core.h and move all core only stuff out of
    iio.h.
  staging:iio:sysfs cleanout header for unused definitions.
  staging:iio:events: use IIO_<TYPE> and IIO_MOD_<> instead of
    IIO_EV_CLASS_<TYPE> etc
  staging:iio:trigger push functions that don't need to be generaly
    available down into the core.
  staging:iio:kfifo buffer - push structure definition down into
    implementation.

 drivers/staging/iio/accel/lis3l02dq_core.c |   24 +++---
 drivers/staging/iio/accel/sca3000_core.c   |   18 ++--
 drivers/staging/iio/adc/ad7150.c           |    8 +-
 drivers/staging/iio/adc/ad7816.c           |    2 +-
 drivers/staging/iio/adc/ad799x_core.c      |    4 +-
 drivers/staging/iio/adc/adt75.c            |    2 +-
 drivers/staging/iio/adc/max1363_core.c     |   24 ++---
 drivers/staging/iio/dac/ad5504.c           |    2 +-
 drivers/staging/iio/iio.h                  |   69 +--------------
 drivers/staging/iio/iio_core.h             |   48 ++++++++++
 drivers/staging/iio/iio_core_trigger.h     |    5 +-
 drivers/staging/iio/industrialio-core.c    |  138 +++++++++++-----------------
 drivers/staging/iio/industrialio-ring.c    |    1 +
 drivers/staging/iio/industrialio-trigger.c |   53 +++++++----
 drivers/staging/iio/kfifo_buf.c            |    8 ++
 drivers/staging/iio/kfifo_buf.h            |    8 --
 drivers/staging/iio/light/tsl2563.c        |    2 +-
 drivers/staging/iio/sysfs.h                |   71 +--------------
 drivers/staging/iio/trigger.h              |   39 --------
 19 files changed, 186 insertions(+), 340 deletions(-)
 create mode 100644 drivers/staging/iio/iio_core.h

-- 
1.7.3.4
