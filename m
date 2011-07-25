Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 0/3] blue part 7: IIO Allow for more channels.
Date: Mon, 25 Jul 2011 14:35:08 +0100
Message-Id: <1311600911-20353-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

First a cleanup to remove the support for multiple event interfaces.
It has been broken for a long time and no one was using it anyway.

Second replaces the int masks with bitmaps to allow for many more channels.

Third switchs to larger event code simplifying code and allowing more space.

Thanks,

Jonathan

Jonathan Cameron (3):
  staging:iio: remove broken support for multiple event interfaces.
  staging:iio: Switch the channel masks to bitmaps so as to allow for  
      more channels.
  staging:iio:events - new 64 bit code structure and push out drivers.

 drivers/staging/iio/accel/lis3l02dq_core.c |   21 ++--
 drivers/staging/iio/accel/lis3l02dq_ring.c |    5 +-
 drivers/staging/iio/accel/sca3000_core.c   |   19 ++--
 drivers/staging/iio/adc/ad7150.c           |   21 ++--
 drivers/staging/iio/adc/ad7291.c           |   13 +--
 drivers/staging/iio/adc/ad7298_ring.c      |    4 +-
 drivers/staging/iio/adc/ad7745.c           |    5 +-
 drivers/staging/iio/adc/ad7793.c           |   18 ++--
 drivers/staging/iio/adc/ad7816.c           |    5 +-
 drivers/staging/iio/adc/ad7887.h           |    4 +-
 drivers/staging/iio/adc/ad7887_ring.c      |   10 +-
 drivers/staging/iio/adc/ad799x.h           |    4 +-
 drivers/staging/iio/adc/ad799x_core.c      |    6 +-
 drivers/staging/iio/adc/ad799x_ring.c      |   18 +--
 drivers/staging/iio/adc/adt7310.c          |    7 +-
 drivers/staging/iio/adc/adt7410.c          |    7 +-
 drivers/staging/iio/adc/adt75.c            |    3 +-
 drivers/staging/iio/adc/max1363.h          |    8 +-
 drivers/staging/iio/adc/max1363_core.c     |   51 +++++-----
 drivers/staging/iio/adc/max1363_ring.c     |   22 ++--
 drivers/staging/iio/addac/adt7316.c        |   18 ++--
 drivers/staging/iio/chrdev.h               |    2 +-
 drivers/staging/iio/dac/ad5504.c           |    4 +-
 drivers/staging/iio/iio.h                  |   51 +++++-----
 drivers/staging/iio/imu/adis16400_ring.c   |    9 +-
 drivers/staging/iio/industrialio-core.c    |  160 +++++++++++++---------------
 drivers/staging/iio/industrialio-ring.c    |   91 +++++++++++++++-
 drivers/staging/iio/light/tsl2563.c        |   15 ++--
 drivers/staging/iio/meter/ade7758.h        |    2 +-
 drivers/staging/iio/meter/ade7758_core.c   |    2 +-
 drivers/staging/iio/meter/ade7758_ring.c   |    2 +-
 drivers/staging/iio/ring_generic.h         |   64 +----------
 drivers/staging/iio/sysfs.h                |   36 ++++---
 33 files changed, 360 insertions(+), 347 deletions(-)

-- 
1.7.3.4
