Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Barry.Song@analog.com, Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 0/6] Various cleanups.
Date: Fri, 25 Jun 2010 16:55:08 +0100
Message-Id: <1277481314-31717-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

This patch set is the result of taking a look at Barry Song's
RFC.  The idea was to get the simple uncontroversial elements
of that in place before we move on to discussion of the more
involved elements.

One or two general cleanups have slipped in here as well.

Jonathan Cameron (6):
  staging:iio: Use kasprintf to allocate and fill trig->name
  staging:iio:lis3l02dq remove unused set_ring_length function
  staging:iio: Add and convert drivers to use iio_alloc_pollfunc
  staging:iio: Add iio_triggered_ring postenable and predisable + use
    in drivers
  staging:iio: remove timestamp field from trigger and pass instead
    through pollfuncs
  staging:iio: replace combine_8_to_16 with be16_to_cpup where
    possible.

 drivers/staging/iio/accel/adis16209_ring.c         |   51 ++++---------------
 drivers/staging/iio/accel/adis16209_trigger.c      |   10 ++--
 drivers/staging/iio/accel/adis16240_ring.c         |   51 ++++---------------
 drivers/staging/iio/accel/adis16240_trigger.c      |   10 ++--
 drivers/staging/iio/accel/lis3l02dq_ring.c         |   53 +++++---------------
 drivers/staging/iio/adc/max1363_ring.c             |   45 ++---------------
 drivers/staging/iio/gyro/adis16260_ring.c          |   51 ++++---------------
 drivers/staging/iio/gyro/adis16260_trigger.c       |   10 ++--
 drivers/staging/iio/imu/adis16300_ring.c           |   51 ++++---------------
 drivers/staging/iio/imu/adis16300_trigger.c        |   10 ++--
 drivers/staging/iio/imu/adis16350_ring.c           |   51 ++++---------------
 drivers/staging/iio/imu/adis16350_trigger.c        |   10 ++--
 drivers/staging/iio/imu/adis16400_ring.c           |   51 ++++---------------
 drivers/staging/iio/imu/adis16400_trigger.c        |   10 ++--
 drivers/staging/iio/industrialio-trigger.c         |   48 ++++++++++++++----
 drivers/staging/iio/trigger.h                      |   24 ++++++---
 drivers/staging/iio/trigger/iio-trig-gpio.c        |   12 ++---
 .../staging/iio/trigger/iio-trig-periodic-rtc.c    |   15 ++----
 18 files changed, 164 insertions(+), 399 deletions(-)
