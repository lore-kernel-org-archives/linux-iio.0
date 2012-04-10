Return-Path: <jic23@hermes.cam.ac.uk>
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: device-drivers-devel@blackfin.uclinux.org,
	Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 00/14] IIO: Kill off IIO_CHAN macro.
Date: Tue, 10 Apr 2012 21:21:36 +0100
Message-Id: <1334089310-22576-1-git-send-email-jic23@kernel.org>
Sender: "J.I. Cameron" <jic23@hermes.cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

This one has been on my mental todo list for a while. As long
as it was there, from time to time a new driver would get
proposed using it thus wasting some poor developers time.

This kills off the remaing users and gets rid of it!

Please can people sanity check I haven't messed up the
removal in their drivers (and anyone elses if they are
bored enough!)

Jonathan

Jonathan Cameron (14):
  staging:iio:accel:adis16201 unwind use of IIO_CHAN macro.
  staging:iio:accel:adis16203 unwind use of IIO_CHAN macro.
  staging:iio:accel:adis16204 unwind use of IIO_CHAN macro.
  staging:iio:accel:adis16209 unwind use of IIO_CHAN macro.
  staging:iio:accel:adis16240 unwind use of IIO_CHAN macro.
  staging:iio:accel:lis3l02dq unwind use of IIO_CHAN macro.
  staging:iio:accel:sca3000 unwind use of IIO_CHAN macro.
  staging:iio:adc:ad7298 unwind use of IIO_CHAN macro.
  staging:iio:adc:ad7476 unwind use of IIO_CHAN macro.
  staging:iio:accel:ad7780 unwind use of IIO_CHAN macro.
  staging:iio:gyro:adis16260 unwind use of IIO_CHAN macro.
  staging:iio:impedance-analyzer:ad5933 unwind use of IIO_CHAN macro.
  staging:iio:meter:ade7758 unwind use of IIO_CHAN macro.
  staging:iio:core drop the IIO_CHAN macro for ease of maintenance.

 drivers/staging/iio/accel/adis16201_core.c      |  116 +++++++---
 drivers/staging/iio/accel/adis16203_core.c      |   87 ++++++--
 drivers/staging/iio/accel/adis16204_core.c      |   92 +++++---
 drivers/staging/iio/accel/adis16209_core.c      |  135 ++++++++----
 drivers/staging/iio/accel/adis16240_core.c      |  103 ++++++---
 drivers/staging/iio/accel/lis3l02dq_core.c      |   25 ++-
 drivers/staging/iio/accel/sca3000_core.c        |   26 ++-
 drivers/staging/iio/adc/ad7298_core.c           |   63 +++---
 drivers/staging/iio/adc/ad7476_core.c           |   45 ++--
 drivers/staging/iio/adc/ad7780.c                |   30 ++-
 drivers/staging/iio/gyro/adis16260_core.c       |   89 +++++---
 drivers/staging/iio/iio.h                       |   17 --
 drivers/staging/iio/impedance-analyzer/ad5933.c |   47 ++++-
 drivers/staging/iio/meter/ade7758_core.c        |  256 +++++++++++++++++------
 14 files changed, 813 insertions(+), 318 deletions(-)

-- 
1.7.9.4
