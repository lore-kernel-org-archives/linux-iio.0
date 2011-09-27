Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:53450 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752350Ab1I0IsW (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 27 Sep 2011 04:48:22 -0400
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org, greg@kroah.com
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH] staging:iio: unwind IIO_IN -> IIO_VOLTAGE define.
Date: Tue, 27 Sep 2011 09:56:40 +0100
Message-Id: <1317113801-21838-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Prequel to [PATCH 00/16] staging:iio:ad799x/ad7606/ad7887 cleanups.
As Greg discovered, my local tags were wrong and the above series
doesn't actually apply to his tree (I had this tagged as already
gone - oops).  Hopefully this is the only difference between
our trees.

This is a trivial cleanup of an original churn avoidance define.
When we introduced the in_ and out_ prefixes I wanted to keep
the churn in drivers down to keep that already invasive patch
as clean as possible.  Now that is in place, we can unwind
the hack that allowed that for the few remaining users.

Note this may well break out of tree drivers that had been
muddling along with the old definition.

Jonathan

Jonathan Cameron (1):
  staging:iio: unwind the IIO_IN -> IIO_VOLTAGE define

 drivers/staging/iio/accel/adis16201_core.c      |    6 +-
 drivers/staging/iio/accel/adis16203_core.c      |    6 +-
 drivers/staging/iio/accel/adis16204_core.c      |    6 +-
 drivers/staging/iio/accel/adis16209_core.c      |    6 +-
 drivers/staging/iio/accel/adis16220_core.c      |    8 +-
 drivers/staging/iio/accel/adis16240_core.c      |    6 +-
 drivers/staging/iio/accel/kxsd9.c               |    2 +-
 drivers/staging/iio/adc/ad7150.c                |    8 +-
 drivers/staging/iio/adc/ad7291.c                |    4 +-
 drivers/staging/iio/adc/ad7298_core.c           |   16 ++--
 drivers/staging/iio/adc/ad7476_core.c           |   16 ++--
 drivers/staging/iio/adc/ad7606_core.c           |   36 +++++-----
 drivers/staging/iio/adc/ad7780.c                |    4 +-
 drivers/staging/iio/adc/ad7793.c                |    2 +-
 drivers/staging/iio/adc/ad7887_core.c           |    4 +-
 drivers/staging/iio/adc/ad799x_core.c           |   80 +++++++++++-----------
 drivers/staging/iio/adc/max1363_core.c          |   24 +++++--
 drivers/staging/iio/addac/adt7316.c             |    8 +-
 drivers/staging/iio/gyro/adis16060_core.c       |    4 +-
 drivers/staging/iio/gyro/adis16080_core.c       |    4 +-
 drivers/staging/iio/gyro/adis16260_core.c       |    6 +-
 drivers/staging/iio/iio.h                       |    4 -
 drivers/staging/iio/impedance-analyzer/ad5933.c |    4 +-
 drivers/staging/iio/imu/adis16400_core.c        |    8 +-
 drivers/staging/iio/meter/ade7758_core.c        |    6 +-
 25 files changed, 141 insertions(+), 137 deletions(-)

-- 
1.7.3.4

