Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:57238 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753995Ab1HLQBA (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 12 Aug 2011 12:01:00 -0400
From: Jonathan Cameron <jic23@cam.ac.uk>
To: greg@kroah.com
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 00/19] staging:iio:cleanups - post fixes
Date: Fri, 12 Aug 2011 17:08:34 +0100
Message-Id: <1313165333-3951-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Greg,

Apply post the previous fixes set please.

This is also hopefully a fairly uncontroversial set.

There may be some issues with any new drivers that cross with it
merging, so give me a shout if that happens.

The last 2 patches get rid of dev_data which should stop any new
drivers from doing things 'the old way.'

Now we have the iio_chan_spec based registration a lot of the
device type specific headers are pointless and hence we get
rid of them. The first once goes here, others are post the
next set of conversions.

Thanks,

Jonathan

Jonathan Cameron (19):
  staging:iio:trivial sparse related cleanups.
  staging:iio:imu:adis16400: use strtobool for reset sysfs and don't
    assign unused tx members.
  staging:iio:imu:adis16400 remove now unused headers.
  staging:iio:triggers introduce iio_trigger_ops to take const bits out
    of iio_trig_structure.
  staging:iio:gyro:adis16260 remove some unused headers
  staging:iio:imu:adis16400 remove unused headers.
  staging:iio:gyro:adis16130 drop control of adc resolution.
  staging:iio:accel: usused header removals.
  staging:iio:adc: unused header removals.
  staging:iio:inclinometer.h remove as now unused.
  staging:iio:various header includes that should never have been.
  staging:iio:adc: header cleanup - remove unused.
  staging:iio:accel header housekeeping - remove unecessary includes.
  staging:iio:gyro and meter: header housecleaning.
  staging:iio:core flatten convenience function that only has one user.
  staging:iio:core squash trivial wrappers and use ida allocation func.
  staging:iio:sysfs cleanout header for unused definitions.
  staging:iio:light:tsl2583 allocate chip state with iio_dev
  staging:iio: Remove deprecated dev_data from iio_dev.

 drivers/staging/iio/accel/adis16201_core.c         |    4 -
 drivers/staging/iio/accel/adis16201_ring.c         |    5 -
 drivers/staging/iio/accel/adis16201_trigger.c      |   13 +-
 drivers/staging/iio/accel/adis16203_core.c         |    3 -
 drivers/staging/iio/accel/adis16203_ring.c         |    8 -
 drivers/staging/iio/accel/adis16203_trigger.c      |   14 +-
 drivers/staging/iio/accel/adis16204_ring.c         |    8 -
 drivers/staging/iio/accel/adis16204_trigger.c      |   14 +-
 drivers/staging/iio/accel/adis16209_core.c         |    3 -
 drivers/staging/iio/accel/adis16209_ring.c         |    8 -
 drivers/staging/iio/accel/adis16209_trigger.c      |   14 +-
 drivers/staging/iio/accel/adis16240_core.c         |    2 -
 drivers/staging/iio/accel/adis16240_ring.c         |    8 -
 drivers/staging/iio/accel/adis16240_trigger.c      |   14 +-
 drivers/staging/iio/accel/inclinometer.h           |   25 ---
 drivers/staging/iio/accel/lis3l02dq_core.c         |    2 -
 drivers/staging/iio/accel/lis3l02dq_ring.c         |   15 +-
 drivers/staging/iio/accel/sca3000_core.c           |    3 +-
 drivers/staging/iio/accel/sca3000_ring.c           |   71 -------
 drivers/staging/iio/adc/ad7150.c                   |    2 +
 drivers/staging/iio/adc/ad7298_core.c              |    1 -
 drivers/staging/iio/adc/ad7298_ring.c              |    3 -
 drivers/staging/iio/adc/ad7476_core.c              |    1 -
 drivers/staging/iio/adc/ad7476_ring.c              |    2 -
 drivers/staging/iio/adc/ad7606_core.c              |    1 -
 drivers/staging/iio/adc/ad7606_ring.c              |    2 -
 drivers/staging/iio/adc/ad7780.c                   |    1 -
 drivers/staging/iio/adc/ad7793.c                   |    1 -
 drivers/staging/iio/adc/ad7887_core.c              |    2 +-
 drivers/staging/iio/adc/ad7887_ring.c              |    3 -
 drivers/staging/iio/adc/ad799x_core.c              |   13 +-
 drivers/staging/iio/adc/ad799x_ring.c              |    3 -
 drivers/staging/iio/adc/max1363_core.c             |   23 ++-
 drivers/staging/iio/adc/max1363_ring.c             |    4 -
 drivers/staging/iio/dac/ad5791.c                   |    1 -
 drivers/staging/iio/gyro/adis16130_core.c          |   76 +-------
 drivers/staging/iio/gyro/adis16260_core.c          |    2 -
 drivers/staging/iio/gyro/adis16260_ring.c          |    8 -
 drivers/staging/iio/gyro/adis16260_trigger.c       |   14 +-
 drivers/staging/iio/iio.h                          |   17 +--
 drivers/staging/iio/imu/adis16400_core.c           |   28 +--
 drivers/staging/iio/imu/adis16400_ring.c           |    8 -
 drivers/staging/iio/imu/adis16400_trigger.c        |   14 +-
 drivers/staging/iio/industrialio-core.c            |  130 +++++-------
 drivers/staging/iio/industrialio-trigger.c         |   16 +-
 drivers/staging/iio/light/tsl2563.c                |    2 +-
 drivers/staging/iio/light/tsl2583.c                |  220 +++++++++-----------
 drivers/staging/iio/meter/ade7758_ring.c           |    9 -
 drivers/staging/iio/meter/ade7758_trigger.c        |   16 +-
 drivers/staging/iio/meter/ade7854.c                |    2 +-
 drivers/staging/iio/sysfs.h                        |   45 +----
 drivers/staging/iio/trigger.h                      |   36 ++-
 drivers/staging/iio/trigger/iio-trig-bfin-timer.c  |    6 +-
 drivers/staging/iio/trigger/iio-trig-gpio.c        |    6 +-
 .../staging/iio/trigger/iio-trig-periodic-rtc.c    |    7 +-
 drivers/staging/iio/trigger/iio-trig-sysfs.c       |    6 +-
 56 files changed, 311 insertions(+), 654 deletions(-)
 delete mode 100644 drivers/staging/iio/accel/inclinometer.h

-- 
1.7.3.4

