Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pa0-f67.google.com ([209.85.220.67]:35405 "EHLO
	mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751848AbcDXNwc (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 24 Apr 2016 09:52:32 -0400
Received: by mail-pa0-f67.google.com with SMTP id zy2so15374317pac.2
        for <linux-iio@vger.kernel.org>; Sun, 24 Apr 2016 06:52:31 -0700 (PDT)
From: Akinobu Mita <akinobu.mita@gmail.com>
To: linux-iio@vger.kernel.org
Cc: Akinobu Mita <akinobu.mita@gmail.com>
Subject: [PATCH v3 0/2] iio: pressure: bmp280: add support for BMP180 and oversampling rate control
Date: Sun, 24 Apr 2016 22:52:09 +0900
Message-Id: <1461505931-21884-1-git-send-email-akinobu.mita@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This series includes two patches: one that adds support for the BMP180
chip, and the second which adds configuration for the oversampling ratio
for both BMP180 and BMP280.

* v3
- use single line comment style where possible suggested by Jonathan Cameron
- remove double casts for calibration coefficients by using adequate data
  types, suggested by Jonathan Cameron
- fix oversampling register setting for bmp280, spotted by Vlad Dogaru

* v2
- split into two patches
- add error check for reading calibration data.
- s/be16_to_cpu(0)/cpu_to_be16(0)/
- default pressure oversampling ratio for bmp180 from x1 to x8
- add kconfig dependency to not select if bmp085-i2c is enabled
- create bmp280_chip_info includes all elements depending on the chip
- add ACPI ids for bmp180

Akinobu Mita (2):
  iio: pressure: bmp280: add support for BMP180
  iio: pressure: bmp280: add ability to control oversampling rate

 drivers/iio/pressure/Kconfig  |   5 +-
 drivers/iio/pressure/bmp280.c | 564 +++++++++++++++++++++++++++++++++++++++---
 2 files changed, 538 insertions(+), 31 deletions(-)

-- 
2.5.0

