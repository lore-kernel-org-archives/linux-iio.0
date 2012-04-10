Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-50.csi.cam.ac.uk ([131.111.8.150]:36129 "EHLO
	ppsw-50.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759396Ab2DJU1u (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 10 Apr 2012 16:27:50 -0400
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: device-drivers-devel@blackfin.uclinux.org,
	michael.hennerich@analog.com, Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 00/10] IIO: Make the value attribute optional for channels
Date: Tue, 10 Apr 2012 21:27:33 +0100
Message-Id: <1334089663-22900-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Dear All,

This came out of a discussion about Michael's variable gain amplifier
driver the other day.  We have devices that have a channel that we
can't actually read, but know other things about. (there are other
cases that we have previously fudged around).

Anyhow, here is the promised series making the value optional.
Has recieved limited testing and I may well have fried someones
driver so please do take a look and test test test!

Dependent on the IIO_CHAN removal series.

Note I'll probably handle this set a little differently from
usual and send the first 9 to Greg asap, but hold the 10th
that actually makes them active until I'm sure there aren't
any drivers going to cross with it and end up broken.

Jonathan



Jonathan Cameron (10):
  staging:iio: add a value element to the info_mask
  staging:iio:accelerometer Add IIO_CHAN_INFO_VALUE entries to all
    drivers.
  staging:iio:adc Add IIO_CHAN_INFO_VALUE entries to all drivers.
  staging:iio:dac Add IIO_CHAN_INFO_VALUE entries to all drivers.
  staging:iio:gyro Add IIO_CHAN_INFO_VALUE entries to all drivers.
  staging:iio:imu Add IIO_CHAN_INFO_VALUE entries to all drivers.
  staging:iio:light Add IIO_CHAN_INFO_VALUE entries to all drivers.
  staging:iio:magnetometer Add IIO_CHAN_INFO_VALUE entries to all
    drivers.
  staging:iio:resolver Add IIO_CHAN_INFO_VALUE entries to all drivers.
  staging:iio: Make read / write attributes for channel values
    optional.

 drivers/staging/iio/accel/adis16201_core.c |   23 ++++--
 drivers/staging/iio/accel/adis16203_core.c |   15 ++--
 drivers/staging/iio/accel/adis16204_core.c |   15 ++--
 drivers/staging/iio/accel/adis16209_core.c |   22 +++--
 drivers/staging/iio/accel/adis16220_core.c |   13 ++-
 drivers/staging/iio/accel/adis16240_core.c |   16 ++--
 drivers/staging/iio/accel/kxsd9.c          |    4 +-
 drivers/staging/iio/accel/lis3l02dq_core.c |    3 +-
 drivers/staging/iio/accel/sca3000_core.c   |    2 +-
 drivers/staging/iio/adc/ad7192.c           |    9 ++-
 drivers/staging/iio/adc/ad7280a.c          |    7 +-
 drivers/staging/iio/adc/ad7291.c           |    8 +-
 drivers/staging/iio/adc/ad7298_core.c      |    8 +-
 drivers/staging/iio/adc/ad7476_core.c      |    5 +-
 drivers/staging/iio/adc/ad7606_core.c      |   19 ++---
 drivers/staging/iio/adc/ad7780.c           |    8 +-
 drivers/staging/iio/adc/ad7793.c           |   38 ++++++---
 drivers/staging/iio/adc/ad7887_core.c      |    8 +-
 drivers/staging/iio/adc/ad799x_core.c      |   40 ++++++++-
 drivers/staging/iio/adc/lpc32xx_adc.c      |   15 ++--
 drivers/staging/iio/adc/max1363_core.c     |    5 +-
 drivers/staging/iio/dac/ad5064.c           |    7 +-
 drivers/staging/iio/dac/ad5360.c           |    7 +-
 drivers/staging/iio/dac/ad5380.c           |    7 +-
 drivers/staging/iio/dac/ad5421.c           |    7 +-
 drivers/staging/iio/dac/ad5446.c           |    5 +-
 drivers/staging/iio/dac/ad5504.c           |    7 +-
 drivers/staging/iio/dac/ad5624r_spi.c      |    5 +-
 drivers/staging/iio/dac/ad5686.c           |    7 +-
 drivers/staging/iio/dac/ad5764.c           |    7 +-
 drivers/staging/iio/dac/ad5791.c           |    7 +-
 drivers/staging/iio/gyro/adis16060_core.c  |    8 +-
 drivers/staging/iio/gyro/adis16080_core.c  |    6 +-
 drivers/staging/iio/gyro/adis16130_core.c  |    2 +
 drivers/staging/iio/gyro/adis16260_core.c  |   15 ++--
 drivers/staging/iio/gyro/adxrs450_core.c   |   14 ++--
 drivers/staging/iio/iio.h                  |    4 +-
 drivers/staging/iio/imu/adis16400_core.c   |  121 ++++++++++++++++++----------
 drivers/staging/iio/industrialio-core.c    |   34 ++++----
 drivers/staging/iio/light/isl29018.c       |    7 +-
 drivers/staging/iio/light/tsl2563.c        |    9 ++-
 drivers/staging/iio/magnetometer/ak8975.c  |    5 +-
 drivers/staging/iio/magnetometer/hmc5843.c |    5 +-
 drivers/staging/iio/resolver/ad2s1200.c    |    2 +
 drivers/staging/iio/resolver/ad2s1210.c    |    2 +
 drivers/staging/iio/resolver/ad2s90.c      |    1 +
 46 files changed, 388 insertions(+), 196 deletions(-)

-- 
1.7.9.4

