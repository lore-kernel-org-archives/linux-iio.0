Return-Path: <mranostay@gmail.com>
From: Matt Ranostay <mranostay@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	marex@denx.de,
	linux-pm@vger.kernel.org,
	Matt Ranostay <mranostay@gmail.com>
Subject: [PATCH v3 0/2] iio: light: add support for APDS9660 sensor
Date: Sun, 12 Jul 2015 19:20:41 -0700
Message-Id: <1436754043-6232-1-git-send-email-mranostay@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

This patchset adds support for the APDS9960 ALS + proximity + gesture
sensor.

Included support for the various adjustable settings and controls:
 * Falling and rising ALS + proximity thresholds events
 * Gain controls
 * ALS time integration

Changes from v2:
 * Remove un-needed scan channel data
 * Typo correction in pm_runtime* initialization

Matt Ranostay (2):
  iio: light: DT binding docs for APDS9960 driver
  iio: light: add APDS9960 ALS + promixity driver

 .../ABI/testing/sysfs-bus-iio-light-apds9960       |  128 +++
 .../devicetree/bindings/iio/light/apds9960.txt     |   19 +
 drivers/iio/light/Kconfig                          |   12 +
 drivers/iio/light/Makefile                         |    1 +
 drivers/iio/light/apds9960.c                       | 1208 ++++++++++++++++++++
 5 files changed, 1368 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-light-apds9960
 create mode 100644 Documentation/devicetree/bindings/iio/light/apds9960.txt
 create mode 100644 drivers/iio/light/apds9960.c

-- 
1.9.1
