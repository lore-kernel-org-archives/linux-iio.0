Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Barry.Song@analog.com, Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 0/2] Cleanups part 2.
Date: Fri, 25 Jun 2010 17:57:02 +0100
Message-Id: <1277485024-10726-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Yet more code clean ups from Barry Song's RFC.

The first fixes a unnecessary restriction I added when originally
adding the drivers (oops).

The second is equivalent of part of Barry's RFC

Jonathan Cameron (2):
  staging:iio:imu  allow adis16300 and adis16400 to build without ring
    buffer support.
  staging:iio: Add stubs for iio_ring_buffer_[un]register and
    equivalent driver stubs

 drivers/staging/iio/accel/adis16209.h      |   11 -----------
 drivers/staging/iio/accel/adis16209_core.c |    7 ++++---
 drivers/staging/iio/accel/adis16209_ring.c |   10 ----------
 drivers/staging/iio/accel/adis16240.h      |   11 -----------
 drivers/staging/iio/accel/adis16240_core.c |    7 ++++---
 drivers/staging/iio/accel/adis16240_ring.c |    9 ---------
 drivers/staging/iio/accel/lis3l02dq.h      |    9 ---------
 drivers/staging/iio/accel/lis3l02dq_core.c |    7 ++++---
 drivers/staging/iio/accel/lis3l02dq_ring.c |   10 ----------
 drivers/staging/iio/adc/max1363.h          |   13 -------------
 drivers/staging/iio/adc/max1363_core.c     |    4 ++--
 drivers/staging/iio/adc/max1363_ring.c     |   10 ----------
 drivers/staging/iio/gyro/adis16260.h       |   11 -----------
 drivers/staging/iio/gyro/adis16260_core.c  |   10 ++++------
 drivers/staging/iio/gyro/adis16260_ring.c  |   10 ----------
 drivers/staging/iio/imu/Kconfig            |   10 ++++------
 drivers/staging/iio/imu/adis16300_core.c   |    7 ++++---
 drivers/staging/iio/imu/adis16300_ring.c   |    9 ---------
 drivers/staging/iio/imu/adis16350.h        |   20 --------------------
 drivers/staging/iio/imu/adis16350_core.c   |    7 ++++---
 drivers/staging/iio/imu/adis16350_ring.c   |    9 ---------
 drivers/staging/iio/imu/adis16400.h        |   11 -----------
 drivers/staging/iio/imu/adis16400_core.c   |    7 ++++---
 drivers/staging/iio/imu/adis16400_ring.c   |   10 ----------
 drivers/staging/iio/ring_generic.h         |   11 +++++++++++
 25 files changed, 45 insertions(+), 195 deletions(-)
