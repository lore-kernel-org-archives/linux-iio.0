Return-Path: <SRS0=wolE=JC=gmail.com=akinobu.mita@kernel.org>
From: Akinobu Mita <akinobu.mita@gmail.com>
To: linux-iio@vger.kernel.org
Cc: Akinobu Mita <akinobu.mita@gmail.com>,
	Eva Rachel Retuya <eraretuya@gmail.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 0/4] iio: accel: adxl345: add calibration offset and sampling frequency support
Date: Sun, 17 Jun 2018 00:04:39 +0900
Message-Id: <1529161484-28781-1-git-send-email-akinobu.mita@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

This patchset adds calibration offset and sampling frequency support for
adxl345 driver with some preparatory changes.

Akinobu Mita (4):
  iio: accel: adxl345: add link to datasheet
  iio: accel: adxl345: use scan_index for accessing accel registers
  iio: accel: adxl345: add calibration offset support
  iio: accel: adxl345: add sampling frequency support

 drivers/iio/accel/adxl345_core.c | 126 +++++++++++++++++++++++++++++++++++----
 1 file changed, 115 insertions(+), 11 deletions(-)

Cc: Eva Rachel Retuya <eraretuya@gmail.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>
-- 
2.7.4
