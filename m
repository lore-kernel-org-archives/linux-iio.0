Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:51180 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752727Ab1KGObb (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 7 Nov 2011 09:31:31 -0500
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 0/2] staging:iio:namespace move to make space
Date: Mon,  7 Nov 2011 14:31:26 +0000
Message-Id: <1320676288-11395-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This entire purpose of this set is to make the minimal changes
required to avoid a namespace clash with the out of staging tree
as we build that up.

My intent will be to push these to Greg as soon as staging-next gets
properly going again.  Then I can do a linux-next request to Stephen
Rothwell (stating it must go after staging-next).

If anyone has a chance to sanity check I didn't mess this up that
would be great!

Jonathan

Jonathan Cameron (2):
  staging:iio:namespace move iio_device_register ->
    iio_st_device_register
  staging:iio: move kconfig symbol from IIO to IIO_ST to make space.

 drivers/staging/Makefile                        |    2 +-
 drivers/staging/iio/Documentation/device.txt    |    4 ++--
 drivers/staging/iio/Kconfig                     |    6 +++---
 drivers/staging/iio/Makefile                    |    2 +-
 drivers/staging/iio/accel/adis16201_core.c      |    4 ++--
 drivers/staging/iio/accel/adis16203_core.c      |    4 ++--
 drivers/staging/iio/accel/adis16204_core.c      |    4 ++--
 drivers/staging/iio/accel/adis16209_core.c      |    4 ++--
 drivers/staging/iio/accel/adis16220_core.c      |    6 +++---
 drivers/staging/iio/accel/adis16240_core.c      |    4 ++--
 drivers/staging/iio/accel/kxsd9.c               |    4 ++--
 drivers/staging/iio/accel/lis3l02dq_core.c      |    4 ++--
 drivers/staging/iio/accel/sca3000_core.c        |    6 +++---
 drivers/staging/iio/adc/ad7192.c                |    4 ++--
 drivers/staging/iio/adc/ad7280a.c               |    6 +++---
 drivers/staging/iio/adc/ad7291.c                |    4 ++--
 drivers/staging/iio/adc/ad7298_core.c           |    4 ++--
 drivers/staging/iio/adc/ad7476_core.c           |    4 ++--
 drivers/staging/iio/adc/ad7606_core.c           |    4 ++--
 drivers/staging/iio/adc/ad7780.c                |    4 ++--
 drivers/staging/iio/adc/ad7793.c                |    4 ++--
 drivers/staging/iio/adc/ad7816.c                |    4 ++--
 drivers/staging/iio/adc/ad7887_core.c           |    4 ++--
 drivers/staging/iio/adc/ad799x_core.c           |    4 ++--
 drivers/staging/iio/adc/adt7310.c               |    4 ++--
 drivers/staging/iio/adc/adt7410.c               |    4 ++--
 drivers/staging/iio/adc/max1363_core.c          |    4 ++--
 drivers/staging/iio/addac/adt7316.c             |    4 ++--
 drivers/staging/iio/cdc/ad7150.c                |    4 ++--
 drivers/staging/iio/cdc/ad7152.c                |    4 ++--
 drivers/staging/iio/cdc/ad7746.c                |    4 ++--
 drivers/staging/iio/dac/ad5064.c                |    4 ++--
 drivers/staging/iio/dac/ad5360.c                |    4 ++--
 drivers/staging/iio/dac/ad5446.c                |    4 ++--
 drivers/staging/iio/dac/ad5504.c                |    4 ++--
 drivers/staging/iio/dac/ad5624r_spi.c           |    4 ++--
 drivers/staging/iio/dac/ad5686.c                |    4 ++--
 drivers/staging/iio/dac/ad5791.c                |    4 ++--
 drivers/staging/iio/dac/max517.c                |    2 +-
 drivers/staging/iio/dds/ad5930.c                |    4 ++--
 drivers/staging/iio/dds/ad9832.c                |    4 ++--
 drivers/staging/iio/dds/ad9834.c                |    4 ++--
 drivers/staging/iio/dds/ad9850.c                |    4 ++--
 drivers/staging/iio/dds/ad9852.c                |    4 ++--
 drivers/staging/iio/dds/ad9910.c                |    4 ++--
 drivers/staging/iio/dds/ad9951.c                |    4 ++--
 drivers/staging/iio/gyro/adis16060_core.c       |    4 ++--
 drivers/staging/iio/gyro/adis16080_core.c       |    4 ++--
 drivers/staging/iio/gyro/adis16130_core.c       |    4 ++--
 drivers/staging/iio/gyro/adis16260_core.c       |    4 ++--
 drivers/staging/iio/gyro/adxrs450_core.c        |    6 +++---
 drivers/staging/iio/iio.h                       |    8 ++++----
 drivers/staging/iio/iio_simple_dummy.c          |    4 ++--
 drivers/staging/iio/impedance-analyzer/ad5933.c |    4 ++--
 drivers/staging/iio/imu/adis16400_core.c        |    4 ++--
 drivers/staging/iio/industrialio-core.c         |    8 ++++----
 drivers/staging/iio/light/isl29018.c            |    4 ++--
 drivers/staging/iio/light/tsl2563.c             |    4 ++--
 drivers/staging/iio/light/tsl2583.c             |    4 ++--
 drivers/staging/iio/magnetometer/ak8975.c       |    4 ++--
 drivers/staging/iio/magnetometer/hmc5843.c      |    4 ++--
 drivers/staging/iio/meter/ade7753.c             |    4 ++--
 drivers/staging/iio/meter/ade7754.c             |    4 ++--
 drivers/staging/iio/meter/ade7758_core.c        |    4 ++--
 drivers/staging/iio/meter/ade7759.c             |    4 ++--
 drivers/staging/iio/meter/ade7854.c             |    6 +++---
 drivers/staging/iio/resolver/ad2s1200.c         |    4 ++--
 drivers/staging/iio/resolver/ad2s1210.c         |    4 ++--
 drivers/staging/iio/resolver/ad2s90.c           |    4 ++--
 69 files changed, 145 insertions(+), 145 deletions(-)

-- 
1.7.7.2

