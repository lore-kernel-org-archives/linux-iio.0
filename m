Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:36395 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750972AbeFYPXF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 25 Jun 2018 11:23:05 -0400
Received: by mail-pg0-f68.google.com with SMTP id m5-v6so6214770pgd.3
        for <linux-iio@vger.kernel.org>; Mon, 25 Jun 2018 08:23:04 -0700 (PDT)
From: Akinobu Mita <akinobu.mita@gmail.com>
To: linux-iio@vger.kernel.org
Cc: Akinobu Mita <akinobu.mita@gmail.com>,
        Eva Rachel Retuya <eraretuya@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH v4 0/4] iio: accel: adxl345: add calibration offset and sampling frequency support
Date: Tue, 26 Jun 2018 00:22:39 +0900
Message-Id: <1529940163-5149-1-git-send-email-akinobu.mita@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patchset adds calibration offset and sampling frequency support for
adxl345 driver with some preparatory changes.

* v4 (Suggested by Jonathan Cameron)
- Stop abusing scan_index and keep using address field in iio_chan_spec

* v3 (Suggested by Andy Shevchenko)
- Define ADXL345_REG_DATA_AXIS(si) for cleaner register access
- Define ADXL345_REG_OSF_AXIS(si) for cleaner register access
- Calculate sampling frequency at runtime instead of having constant table

* v2
- Adjust the value for the calibbias to make the same scale as the _raw
  measurement, and remove misused calibscale.

Akinobu Mita (4):
  iio: accel: adxl345: add link to datasheet
  iio: accel: adxl345: convert address field usage in iio_chan_spec
  iio: accel: adxl345: add calibration offset support
  iio: accel: adxl345: add sampling frequency support

 drivers/iio/accel/adxl345_core.c | 127 +++++++++++++++++++++++++++++++++++----
 1 file changed, 116 insertions(+), 11 deletions(-)

Cc: Eva Rachel Retuya <eraretuya@gmail.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>
-- 
2.7.4

