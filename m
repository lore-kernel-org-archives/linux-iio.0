Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: manuel.stahl@iis.fraunhofer.de,
	linux-iio@vger.kernel.org
Cc: drivers@analog.com,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 00/10] staging:iio: implement _type attrs for scan elements
Date: Sun, 19 Sep 2010 18:04:24 +0100
Message-Id: <1284915874-24911-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Implementation of Manuel Stahl's suggested interface to describe how
a given scan element is stored in the buffer.

The final patch removes the previous partial implementation of related
functionality.

This is done off a combination of what was marked in the drivers and
datasheets.  Where the in driver elements disagree with the datasheet
I have assumed a bug (be it one that did not previously have any affect)
and gone with the datasheet.

In one case, I don't believe the datasheet so have asked the manufacturer
to confirm.

This is applied on a clean version of staging-next as I would like to
merge this asap and hence do not want to have it dependant on the
two large adis related patch sets I have posted to the mailining list.
Clearly those will both need to be rebased.

Jonathan Cameron (10):
  staging:iio:lis3l02dq add _type attributes for all scan elements
  staging:iio:max1363 add _type attributes for all scan elements
  staging:iio:adis16209 add _type attributes for all scan elements
  staging:iio:adis16240 add _type attributes for all scan elements
  staging:iio:sca3000 add _type attributes for all scan elements
  staging:iio:adis16260 add _type attributes for all scan elements
  staging:iio:adis16300 add _type attributes for all scan elements
  staging:iio:adis16350 add _type attributes for all scan elements
  staging:iio:adis16400 add _type attributes for all scan elements
  staging:iio: Remove unused bit_count from struct iio_scan_el

 drivers/staging/iio/accel/adis16209_ring.c |   36 ++++---
 drivers/staging/iio/accel/adis16240_ring.c |   27 +++--
 drivers/staging/iio/accel/lis3l02dq_ring.c |   10 ++-
 drivers/staging/iio/accel/sca3000_ring.c   |   52 +++++-----
 drivers/staging/iio/adc/max1363_core.c     |  154 +++++++++++++++++-----------
 drivers/staging/iio/gyro/adis16260_ring.c  |   27 +++--
 drivers/staging/iio/imu/adis16300_ring.c   |   39 +++++---
 drivers/staging/iio/imu/adis16350_ring.c   |   44 ++++----
 drivers/staging/iio/imu/adis16400_ring.c   |   50 +++++----
 drivers/staging/iio/ring_generic.h         |   17 +--
 10 files changed, 261 insertions(+), 195 deletions(-)

-- 
1.7.2.2
