Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:35873 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751415AbdBZNpg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 26 Feb 2017 08:45:36 -0500
From: Eva Rachel Retuya <eraretuya@gmail.com>
To: jic23@kernel.org, linux-iio@vger.kernel.org
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        dmitry.torokhov@gmail.com, michael.hennerich@analog.com,
        daniel.baluta@gmail.com, amsfield22@gmail.com,
        florian.vaussard@heig-vd.ch, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, Eva Rachel Retuya <eraretuya@gmail.com>
Subject: [PATCH v4 0/4] iio: accel: adxl345: Split driver into core and I2C then add SPI support
Date: Sun, 26 Feb 2017 21:45:03 +0800
Message-Id: <cover.1488115521.git.eraretuya@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patchset modifies the adxl345 to use regmap. In doing so, we can
easily introduce SPI support and let regmap handle the rest.

Recap of basic features: read_raw for x, y and z axes, scale. After
applying this series, driver now supports the SPI protocol and enumeration
of device via device tree.

Changes from v3:
[PATCH 1/4] Documentation: dt-bindings: Document ADXL345 accelerometer binding
* None
[PATCH 2/4] iio: accel: adxl345: Use I2C regmap instead of direct I2C access
* Keep intact I2C client structure which was deleted from v3
* Make use of regmap_get_device to retrieve struct device, use these for
  debugging prints instead of &client->dev.
[PATCH 3/4] iio: accel: adxl345: Split driver into core and I2C
 and
[PATCH 4/4] iio: accel: adxl345: Add SPI support
* Revert to explicit and separate I2C and SPI configuration
* Add OF match table, make it enumerable in ACPI environment (Andy's suggestion)

Changes from v2:
* Drop PATCH 4 iio: accel: adxl345: Add ACPI support
* Add OF match table on both I2C and SPI files and document them

Changes from v1:
[PATCH 1/4]
* Move other deletions from patch 2 in here -- make it clear what got deleted
  and/or modified that is hard to see previously
* Introduce the driver header file "adxl345.h" here instead of doing it in the
  next patch
* Completely omit traces of i2c_client and let this file (adxl345.c) mirror the
  core file on the next patch.
* Improve debugging print about invalid device ID in probe.
[PATCH 2/4]
* Update Kconfig to Jonathan's preferred style
* Improve similarity index from 78% to 100% (rename detection)
[PATCH 4/4]
* Correct acpi_device_id: ADX0345 -> ADS0345

Eva Rachel Retuya (4):
  Documentation: dt-bindings: Document ADXL345 accelerometer binding
  iio: accel: adxl345: Use I2C regmap instead of direct I2C access
  iio: accel: adxl345: Split driver into core and I2C
  iio: accel: adxl345: Add SPI support

 .../devicetree/bindings/iio/accel/adxl345.txt      | 38 +++++++++
 drivers/iio/accel/Kconfig                          | 26 ++++++-
 drivers/iio/accel/Makefile                         |  4 +-
 drivers/iio/accel/adxl345.h                        | 18 +++++
 drivers/iio/accel/{adxl345.c => adxl345_core.c}    | 89 +++++++++-------------
 drivers/iio/accel/adxl345_i2c.c                    | 78 +++++++++++++++++++
 drivers/iio/accel/adxl345_spi.c                    | 83 ++++++++++++++++++++
 7 files changed, 281 insertions(+), 55 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/accel/adxl345.txt
 create mode 100644 drivers/iio/accel/adxl345.h
 rename drivers/iio/accel/{adxl345.c => adxl345_core.c} (62%)
 create mode 100644 drivers/iio/accel/adxl345_i2c.c
 create mode 100644 drivers/iio/accel/adxl345_spi.c

-- 
2.7.4

