Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: greg@kroah.com
Cc: linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 0/7] staging:iio:cleanups2 post iio_chan_spec_conversion
Date: Fri, 12 Aug 2011 17:55:58 +0100
Message-Id: <1313168165-16109-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Hi Greg,

Note dependency on previous set.

staging:iio: iio_chan_spec conversions - after cleanups 

Two things here.

1) removal of now unused headers.
2) remove a nasty cludge we used to reduce churn during move to iio_chan_spec.

It's possible either will cause issues for any new drivers crossing with this
set.  Give me a yell if that happens.

Thanks,

Jonathan


Jonathan Cameron (7):
  staging:iio:magnetometer: remove unused header magnet.h
  staging:iio:gyro: remove gyro.h
  staging:iio:accel remove unused accel.h header.
  staging:iio:adc remove unused adc.h.
  staging:iio: Introduce iio_core.h and move all core only stuff out of
    iio.h.
  staging:iio:events: use IIO_<TYPE> and IIO_MOD_<> instead of
    IIO_EV_CLASS_<TYPE> etc
  staging:iio: remove unneeded include

 drivers/staging/iio/accel/accel.h          |   87 ----------------------------
 drivers/staging/iio/accel/lis3l02dq_core.c |   24 ++++----
 drivers/staging/iio/accel/sca3000_core.c   |   16 +++---
 drivers/staging/iio/adc/ad7150.c           |    8 +-
 drivers/staging/iio/adc/ad7816.c           |    2 +-
 drivers/staging/iio/adc/ad799x_core.c      |    4 +-
 drivers/staging/iio/adc/adc.h              |   42 -------------
 drivers/staging/iio/adc/adt75.c            |    2 +-
 drivers/staging/iio/adc/max1363_core.c     |   24 +++-----
 drivers/staging/iio/dac/ad5504.c           |    2 +-
 drivers/staging/iio/gyro/gyro.h            |   85 ---------------------------
 drivers/staging/iio/iio.h                  |   65 +--------------------
 drivers/staging/iio/iio_core.h             |   48 +++++++++++++++
 drivers/staging/iio/industrialio-core.c    |   16 +++---
 drivers/staging/iio/industrialio-ring.c    |    1 +
 drivers/staging/iio/industrialio-trigger.c |    1 +
 drivers/staging/iio/light/tsl2563.c        |    2 +-
 drivers/staging/iio/magnetometer/magnet.h  |   31 ----------
 drivers/staging/iio/sysfs.h                |   28 +---------
 19 files changed, 98 insertions(+), 390 deletions(-)
 delete mode 100644 drivers/staging/iio/accel/accel.h
 delete mode 100644 drivers/staging/iio/adc/adc.h
 delete mode 100644 drivers/staging/iio/gyro/gyro.h
 create mode 100644 drivers/staging/iio/iio_core.h
 delete mode 100644 drivers/staging/iio/magnetometer/magnet.h

-- 
1.7.3.4
