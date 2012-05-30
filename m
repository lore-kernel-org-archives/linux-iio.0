Return-Path: <jic23@kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 0/8] IIO: Cleanups and complicated channel modifiers.
Date: Wed, 30 May 2012 20:40:58 +0100
Message-Id: <1338406866-3833-1-git-send-email-jic23@kernel.org>
List-ID: <linux-iio@vger.kernel.org>

Hi All,

Dropping the reset attributes was discussed a while back and no
one could come up with a reason for having them. Unless anyone
does have a good reason, lets drop these before we move the
relevant drivers out of staging.

The other patches here are more 'interesting' in that they make use of
modifiers for sum squared of xyz and root sum squared of x and y.
These are common enough things to see and to my mind are well handled
as modifiers. What do people think?

Jonathan

Jonathan Cameron (8):
  staging:iio:accel drop sysfs interface for resetting devices.
  staging:iio:gyro:adis16260 drop sysfs interface for manual device
    reset.
  staging:iio:imu:adis16400 drop sysfs interface for manual device
    reset.
  IIO: Add a modifier for sqrt(x^2+y^2)
  staging:iio:accel:adis16204 fix bug in channel modifier handling
  staging:iio:accel:adis16204 support the rss channel via chan spec.
  IIO: Add a modifier for x^2+y^2+z^2
  staging:iio: Add some missing peak elements to the info_mask

 drivers/iio/industrialio-core.c            |    2 +
 drivers/staging/iio/accel/adis16201_core.c |   27 --------
 drivers/staging/iio/accel/adis16203_core.c |   28 --------
 drivers/staging/iio/accel/adis16204_core.c |  103 ++++++++--------------------
 drivers/staging/iio/accel/adis16209_core.c |   29 --------
 drivers/staging/iio/accel/adis16220_core.c |   24 -------
 drivers/staging/iio/accel/adis16240_core.c |   29 ++------
 drivers/staging/iio/gyro/adis16260_core.c  |   19 -----
 drivers/staging/iio/imu/adis16400_core.c   |   22 ------
 include/linux/iio/types.h                  |    2 +
 10 files changed, 39 insertions(+), 246 deletions(-)

-- 
1.7.10.2
