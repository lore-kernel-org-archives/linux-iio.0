Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:37753 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751331Ab1HLQkA (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 12 Aug 2011 12:40:00 -0400
From: Jonathan Cameron <jic23@cam.ac.uk>
To: greg@kroah.com
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 00/12] staging:iio: iio_chan_spec conversions - after cleanups
Date: Fri, 12 Aug 2011 17:47:51 +0100
Message-Id: <1313167683-11881-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Greg,

This lot sit on top of the previous series:

[PATCH 00/19] staging:iio:cleanups - post fixes 

Some more fairly straight forward conversions over to
struct iio_chan_spec based channel description.

These were in the 'IIO: Mixed bunch of updates' that I asked you
to ignore after fun around merge window time and hence have been
around for quite some time.

Thanks,

Jonathan


Jonathan Cameron (12):
  staging:iio:accel:kxsd9 cleanup and conversion to iio_chan_spec.
  staging:iio: add quadrature correction to chan info types.
  staging:iio:gyro:adxrs450 move to iio_chan_spec registration
  staging:iio:gyro:adxrs450 make more use of spi_read and spi_write.
  staging:iio:gyro:adxrs450 squish some trivial single call point
    wrappers functions.
  staging:iio:gyro:adis16080 convert to iio_chan_spec.
  staging:iio:magnetometer:hmc5843 iio_chan_spec conversion.
  staging:iio:gyro:adis16130 move to iio_chan_spec registration.
  staging:iio:gyro:adis16060 convert to iio_chan_spec
  staging:iio:accel:adis16204: use peak_raw info_mask element + push
    some defs down from header.
  staging:iio:accel:adis16220 iio_chan_spec conversion.
  staging:iio:magnetometer:ak8975 convert to iio_chan_spec + cleanups.

 drivers/staging/iio/accel/adis16204_core.c |   47 +++--
 drivers/staging/iio/accel/adis16220_core.c |  342 +++++++++++++++++-----------
 drivers/staging/iio/accel/kxsd9.c          |  268 +++++++++-------------
 drivers/staging/iio/gyro/adis16060_core.c  |  115 +++++-----
 drivers/staging/iio/gyro/adis16080_core.c  |   92 ++++----
 drivers/staging/iio/gyro/adis16130_core.c  |   57 ++---
 drivers/staging/iio/gyro/adxrs450_core.c   |  252 +++++++++------------
 drivers/staging/iio/iio.h                  |    3 +
 drivers/staging/iio/industrialio-core.c    |    2 +
 drivers/staging/iio/magnetometer/ak8975.c  |  214 +++++++++---------
 drivers/staging/iio/magnetometer/hmc5843.c |   96 ++++----
 11 files changed, 751 insertions(+), 737 deletions(-)

-- 
1.7.3.4

