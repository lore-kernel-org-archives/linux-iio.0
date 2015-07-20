Return-Path: <mranostay@gmail.com>
From: Matt Ranostay <mranostay@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	marex@denx.de,
	Matt Ranostay <mranostay@gmail.com>
Subject: [PATCH v4 0/2] iio: light: add support for APDS9660 sensor
Date: Sun, 19 Jul 2015 20:57:18 -0700
Message-Id: <1437364640-7470-1-git-send-email-mranostay@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

This patchset adds support for the APDS9960 ALS + proximity + gesture
sensor.

Included support for the various adjustable settings and controls:
 * Falling and rising ALS + proximity thresholds events
 * Gain controls
 * ALS time integration

Changes from v3:
 * Added interrupt client mode document reference in DT bindings
 * Add missing dep for CONFIG_REGMAP_I2C in respective Kconfig
 * Changed from iio_trigger_poll_chained() to irq_work queue
 * Changed channel masks to prevent channels that can't be polled from
   having sysfs entries
 * Renamed regmap_field declarations with apds9660_* prefix 
 * Added available channel masks and removed unneeded buffer copy in
   poll function
 * Remove unneeded default regmap values in apds9960_reg_defaults 
 * Clear interrupts from ALS and proximity sensor seperately to avoid
   race condition
 * Changed max threshold values to a macro define, and prevent values
   less than 0
 * Avoid needlessly checking the APDS9960_REG_GFLVL value until we read
   all the FIFO from the count value. Note this can save up to 32 
   superfluous i2c reads per gesture engine entry
 
Matt Ranostay (2):
  iio: light: DT binding docs for APDS9960 driver
  iio: light: add APDS9960 ALS + promixity driver

 .../ABI/testing/sysfs-bus-iio-light-apds9960       |    7 +
 .../devicetree/bindings/iio/light/apds9960.txt     |   22 +
 drivers/iio/light/Kconfig                          |   13 +
 drivers/iio/light/Makefile                         |    1 +
 drivers/iio/light/apds9960.c                       | 1191 ++++++++++++++++++++
 5 files changed, 1234 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-light-apds9960
 create mode 100644 Documentation/devicetree/bindings/iio/light/apds9960.txt
 create mode 100644 drivers/iio/light/apds9960.c

-- 
1.9.1
