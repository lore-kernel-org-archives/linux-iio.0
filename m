Return-Path: <jic23@hermes.cam.ac.uk>
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 0/5] IIO mixed bag of trivial + fixes
Date: Sat,  3 Mar 2012 11:39:10 +0000
Message-Id: <1330774755-18031-1-git-send-email-jic23@kernel.org>
Sender: "J.I. Cameron" <jic23@hermes.cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Nothing terribly interesting, but as ever all comments welcome.
If no one shouts I'll assume these are trivial enough to send
on to Greg sometime next week.

Jonathan

Jonathan Cameron (5):
  staging:iio fill in some missing docs
  staging:iio:accel:lis3l02dq add symmetry to check for presence of
    trigger.
  staging:iio: use spi->irq valid rather than querying available modes
  staging:iio:adc:max1363 fix missing update_scan_mask callback.
  staging:iio:iio_core.h make less dependent on other included headers

 drivers/staging/iio/accel/lis3l02dq_core.c |    2 +-
 drivers/staging/iio/adc/max1363_core.c     |    1 +
 drivers/staging/iio/iio.h                  |    2 ++
 drivers/staging/iio/iio_core.h             |    6 ++++++
 drivers/staging/iio/imu/adis16400_core.c   |    2 +-
 drivers/staging/iio/meter/ade7758_core.c   |    2 +-
 6 files changed, 12 insertions(+), 3 deletions(-)

-- 
1.7.9.2
