Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:57435 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751613Ab1JJPR7 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 10 Oct 2011 11:17:59 -0400
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org,
	Device-drivers-devel@blackfin.uclinux.org
Cc: lars@metafoo.de, Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH] staging:iio: fix nasty freeing messup on exit.
Date: Mon, 10 Oct 2011 16:17:55 +0100
Message-Id: <1318259876-7572-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

No idea why this hasn't caused me more issues before today
(when everything started dying).

Anyhow, it was impossible to correctly cleanup buffer related
sysfs attribute arrays as it could not be before the
iio_device_unregister as then the actual file removal
would be using freeded memory.

It could not be after as then we didn't have any way of getting
to it.

Fix is to resplit iio_device_unregister in two and do the
free explicitly in all drivers.

If people can test as many parts as possible asap, I'll
be pushing this onwards as soon as I'm happy I haven't
caused any more fallout.

Note along the way I fixed a few removal paths that wouldn't
have worked anyway.

Thanks,

Jonathan

Jonathan Cameron (1):
  staging:iio: fix removal path to allow correct freeing.

 drivers/staging/iio/accel/adis16201_core.c      |    3 +-
 drivers/staging/iio/accel/adis16203_core.c      |    3 +-
 drivers/staging/iio/accel/adis16204_core.c      |    3 +-
 drivers/staging/iio/accel/adis16209_core.c      |    3 +-
 drivers/staging/iio/accel/adis16220_core.c      |   13 +++++------
 drivers/staging/iio/accel/adis16240_core.c      |    3 +-
 drivers/staging/iio/accel/kxsd9.c               |    1 +
 drivers/staging/iio/accel/lis3l02dq_core.c      |    7 +++--
 drivers/staging/iio/accel/sca3000_core.c        |   13 +++++------
 drivers/staging/iio/adc/ad7150.c                |    3 +-
 drivers/staging/iio/adc/ad7152.c                |    1 +
 drivers/staging/iio/adc/ad7192.c                |   26 ++++++++--------------
 drivers/staging/iio/adc/ad7280a.c               |   19 ++++++++--------
 drivers/staging/iio/adc/ad7291.c                |    4 ++-
 drivers/staging/iio/adc/ad7298_core.c           |    4 +-
 drivers/staging/iio/adc/ad7476_core.c           |    3 +-
 drivers/staging/iio/adc/ad7606_core.c           |    3 +-
 drivers/staging/iio/adc/ad7746.c                |    1 +
 drivers/staging/iio/adc/ad7780.c                |    3 +-
 drivers/staging/iio/adc/ad7793.c                |    3 +-
 drivers/staging/iio/adc/ad7816.c                |    3 +-
 drivers/staging/iio/adc/ad7887_core.c           |    3 +-
 drivers/staging/iio/adc/ad799x_core.c           |    3 +-
 drivers/staging/iio/adc/adt7310.c               |    3 +-
 drivers/staging/iio/adc/adt7410.c               |    3 +-
 drivers/staging/iio/adc/adt75.c                 |    3 +-
 drivers/staging/iio/adc/max1363_core.c          |    3 +-
 drivers/staging/iio/addac/adt7316.c             |    3 +-
 drivers/staging/iio/dac/ad5446.c                |    9 ++++---
 drivers/staging/iio/dac/ad5504.c                |    4 +-
 drivers/staging/iio/dac/ad5624r_spi.c           |    3 +-
 drivers/staging/iio/dac/ad5686.c                |    4 +-
 drivers/staging/iio/dac/ad5791.c                |    5 +--
 drivers/staging/iio/dds/ad5930.c                |    1 +
 drivers/staging/iio/dds/ad9832.c                |    9 ++++---
 drivers/staging/iio/dds/ad9834.c                |    8 +++---
 drivers/staging/iio/dds/ad9850.c                |    1 +
 drivers/staging/iio/dds/ad9852.c                |    1 +
 drivers/staging/iio/dds/ad9910.c                |    1 +
 drivers/staging/iio/dds/ad9951.c                |    1 +
 drivers/staging/iio/gyro/adis16060_core.c       |    1 +
 drivers/staging/iio/gyro/adis16080_core.c       |    1 +
 drivers/staging/iio/gyro/adis16130_core.c       |    1 +
 drivers/staging/iio/gyro/adis16260_core.c       |    4 ++-
 drivers/staging/iio/gyro/adxrs450_core.c        |   11 +++------
 drivers/staging/iio/impedance-analyzer/ad5933.c |    3 +-
 drivers/staging/iio/imu/adis16400_core.c        |    3 +-
 drivers/staging/iio/industrialio-core.c         |    3 --
 drivers/staging/iio/light/isl29018.c            |    1 +
 drivers/staging/iio/light/tsl2563.c             |    5 +++-
 drivers/staging/iio/light/tsl2583.c             |    1 +
 drivers/staging/iio/magnetometer/ak8975.c       |    7 +++--
 drivers/staging/iio/magnetometer/hmc5843.c      |    4 ++-
 drivers/staging/iio/meter/ade7753.c             |    5 ++-
 drivers/staging/iio/meter/ade7754.c             |    3 +-
 drivers/staging/iio/meter/ade7758_core.c        |    5 ++-
 drivers/staging/iio/meter/ade7759.c             |    3 +-
 drivers/staging/iio/meter/ade7854.c             |    1 +
 drivers/staging/iio/resolver/ad2s1200.c         |    1 +
 drivers/staging/iio/resolver/ad2s1210.c         |    4 +-
 drivers/staging/iio/resolver/ad2s90.c           |    1 +
 61 files changed, 148 insertions(+), 110 deletions(-)

-- 
1.7.3.4

