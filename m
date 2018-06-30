Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pl0-f66.google.com ([209.85.160.66]:42493 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751246AbeF3QdA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 30 Jun 2018 12:33:00 -0400
Received: by mail-pl0-f66.google.com with SMTP id y15-v6so4050354pll.9
        for <linux-iio@vger.kernel.org>; Sat, 30 Jun 2018 09:32:59 -0700 (PDT)
From: Akinobu Mita <akinobu.mita@gmail.com>
To: linux-iio@vger.kernel.org
Cc: Akinobu Mita <akinobu.mita@gmail.com>,
        Eva Rachel Retuya <eraretuya@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH v5 0/4] iio: accel: adxl345: add calibration offset and sampling frequency support
Date: Sun,  1 Jul 2018 01:32:41 +0900
Message-Id: <1530376365-23946-1-git-send-email-akinobu.mita@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patchset adds calibration offset and sampling frequency support for
adxl345 driver with some preparatory changes.

* v5 (Suggested by Andy Shevchenko)
- Introduce constant for nHZ per HZ
- Find an register setting without looping over all available frequencies
- Allow all user supplied values and round to an available frequency

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

 drivers/iio/accel/adxl345_core.c | 121 +++++++++++++++++++++++++++++++++++----
 1 file changed, 110 insertions(+), 11 deletions(-)

Cc: Eva Rachel Retuya <eraretuya@gmail.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>
-- 
2.7.4

