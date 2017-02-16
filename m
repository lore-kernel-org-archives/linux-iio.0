Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:36115 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753221AbdBPKCm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 16 Feb 2017 05:02:42 -0500
From: Eva Rachel Retuya <eraretuya@gmail.com>
To: jic23@kernel.org, linux-iio@vger.kernel.org
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        dmitry.torokhov@gmail.com, michael.hennerich@analog.com,
        daniel.baluta@gmail.com, amsfield22@gmail.com,
        florian.vaussard@heig-vd.ch, linux-kernel@vger.kernel.org,
        Eva Rachel Retuya <eraretuya@gmail.com>
Subject: [PATCH 0/4] iio: accel: adxl345: Split driver into core and I2C then add SPI support
Date: Thu, 16 Feb 2017 18:02:03 +0800
Message-Id: <1487239327-21406-1-git-send-email-eraretuya@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patchset modifies the adxl345 to use regmap. In doing so, we can
easily introduce SPI support and let regmap handle the rest.

Recap of basic features: read_raw for x, y and z axes, scale. After
applying this series, driver now supports the SPI protocol and enumeration
of device via ACPI.

Eva Rachel Retuya (4):
  iio: accel: adxl345: Use I2C regmap instead of direct I2C access
  iio: accel: adxl345: Split driver into core and I2C
  iio: accel: adxl345: Add SPI support
  iio: accel: adxl345: Add ACPI support

 drivers/iio/accel/Kconfig        |  22 ++++-
 drivers/iio/accel/Makefile       |   4 +-
 drivers/iio/accel/adxl345.c      | 194 ---------------------------------------
 drivers/iio/accel/adxl345.h      |  18 ++++
 drivers/iio/accel/adxl345_core.c | 182 ++++++++++++++++++++++++++++++++++++
 drivers/iio/accel/adxl345_i2c.c  |  79 ++++++++++++++++
 drivers/iio/accel/adxl345_spi.c  |  84 +++++++++++++++++
 7 files changed, 386 insertions(+), 197 deletions(-)
 delete mode 100644 drivers/iio/accel/adxl345.c
 create mode 100644 drivers/iio/accel/adxl345.h
 create mode 100644 drivers/iio/accel/adxl345_core.c
 create mode 100644 drivers/iio/accel/adxl345_i2c.c
 create mode 100644 drivers/iio/accel/adxl345_spi.c

-- 
2.7.4

