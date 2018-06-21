Return-Path: <SRS0=gWL8=JH=gmail.com=akinobu.mita@kernel.org>
From: Akinobu Mita <akinobu.mita@gmail.com>
To: linux-iio@vger.kernel.org
Cc: Akinobu Mita <akinobu.mita@gmail.com>,
	Eva Rachel Retuya <eraretuya@gmail.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH v3 0/4] iio: accel: adxl345: add calibration offset and sampling frequency support
Date: Fri, 22 Jun 2018 00:39:04 +0900
Message-Id: <1529595548-25215-1-git-send-email-akinobu.mita@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

This patchset adds calibration offset and sampling frequency support for
adxl345 driver with some preparatory changes.

* v3 (Suggested by Andy Shevchenko)
- Define ADXL345_REG_DATA_AXIS(si) for cleaner register access
- Define ADXL345_REG_OSF_AXIS(si) for cleaner register access
- Calculate sampling frequency at runtime instead of having constant table

* v2
- Adjust the value for the calibbias to make the same scale as the _raw
  measurement, and remove misused calibscale.

Akinobu Mita (4):
  iio: accel: adxl345: add link to datasheet
  iio: accel: adxl345: use scan_index for accessing accel registers
  iio: accel: adxl345: add calibration offset support
  iio: accel: adxl345: add sampling frequency support

 drivers/iio/accel/adxl345_core.c | 128 +++++++++++++++++++++++++++++++++++----
 1 file changed, 117 insertions(+), 11 deletions(-)

Cc: Eva Rachel Retuya <eraretuya@gmail.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>
-- 
2.7.4
