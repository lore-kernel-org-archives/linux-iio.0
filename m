Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 0/3] staging:iio: Minor clean ups.
Date: Mon, 17 May 2010 22:35:47 +0100
Message-Id: <1274132150-29256-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Dear All,

These are pretty mundane clean up patches. The first is the 
change the Michael suggested the other day. It gets rid
of some superfluous code.

The third cleans up some useless complexity in the lis3l02dq
driver.  As all interrupts have to be acknowledged, and as none
of the other elements of the iio_work_cont are used, we just
replace it with a single work_struct.

Jonathan Cameron (3):
  staging:iio:max1363 use device_id instead of searching on name again
  staging:iio:max1363 trivial code and comment cleanups.
  staging:iio:lis3l02dq cleanups

 drivers/staging/iio/accel/lis3l02dq.h      |    4 +-
 drivers/staging/iio/accel/lis3l02dq_core.c |   25 ++---
 drivers/staging/iio/accel/lis3l02dq_ring.c |    8 --
 drivers/staging/iio/adc/max1363.h          |    3 +-
 drivers/staging/iio/adc/max1363_core.c     |  156 +++++++++++++--------------
 drivers/staging/iio/adc/max1363_ring.c     |   10 +-
 6 files changed, 92 insertions(+), 114 deletions(-)
