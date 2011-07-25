Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 0/3] blue part 1: IIO Misc fixes.
Date: Mon, 25 Jul 2011 14:04:29 +0100
Message-Id: <1311599072-14637-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Hi All,

This series and the following are all in the iio-blue.git reposistory.

The max1363 has been posted before and is included here for completeness.

Thanks,

Jonathan



Jonathan Cameron (3):
  staging:iio:gyro:adxrs450 fix: wrong variable for IIO_TEMP reading.
  staging:iio:adc: max1363 fix 2 raw sysfs issues.
  staging:iio:core simplify and fix a bug in
    iio_device_(un)register_event_set.

 drivers/staging/iio/adc/max1363_core.c   |    4 ++-
 drivers/staging/iio/gyro/adxrs450_core.c |    2 +-
 drivers/staging/iio/industrialio-core.c  |   40 +++++++++++++++---------------
 3 files changed, 24 insertions(+), 22 deletions(-)

-- 
1.7.3.4
