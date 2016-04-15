Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:33771 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750776AbcDORyE (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 15 Apr 2016 13:54:04 -0400
Received: by mail-pa0-f51.google.com with SMTP id zm5so57400454pac.0
        for <linux-iio@vger.kernel.org>; Fri, 15 Apr 2016 10:54:04 -0700 (PDT)
From: Akinobu Mita <akinobu.mita@gmail.com>
To: linux-iio@vger.kernel.org
Cc: Akinobu Mita <akinobu.mita@gmail.com>
Subject: [PATCH v2 0/2] iio: pressure: bmp280: add support for BMP180 and oversampling rate control
Date: Sat, 16 Apr 2016 02:53:45 +0900
Message-Id: <1460742827-6502-1-git-send-email-akinobu.mita@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This series includes two patches: one that adds support for the BMP180
chip, and the second which adds configuration for the oversampling ratio
for both BMP180 and BMP280.

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
 drivers/iio/pressure/bmp280.c | 581 +++++++++++++++++++++++++++++++++++++++---
 2 files changed, 555 insertions(+), 31 deletions(-)

-- 
2.5.0

