Return-Path: <tiberiu.a.breana@intel.com>
From: Tiberiu Breana <tiberiu.a.breana@intel.com>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH v2 0/2] Add support for Aosong AM2315 relative humidity and ambient temperature sensor
Date: Mon, 18 Apr 2016 12:42:21 +0300
Message-Id: <1460972543-27175-1-git-send-email-tiberiu.a.breana@intel.com>
List-ID: <linux-iio@vger.kernel.org>

This patch set adds basic support for the Aosong AM2315 relative
humidity and ambient temperature sensor.

Patch 1 adds basic support, raw readings and ACPI detection.
Patch 2 adds triggered buffer support.

Changes since v1:

patch 1/2:
- moved driver from iio/temperature to iio/humidity
- addressed Jonathan's comments
- fixed scale to export values in millipercent (humidity) and
  millidegrees (temperature)

patch 2/2:
no changes

Tiberiu Breana (2):
  iio: humidity: Add support for AM2315
  iio: humidity: Add triggered buffer support for AM2315

 drivers/iio/humidity/Kconfig  |  10 ++
 drivers/iio/humidity/Makefile |   1 +
 drivers/iio/humidity/am2315.c | 289 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 300 insertions(+)
 create mode 100644 drivers/iio/humidity/am2315.c

-- 
1.9.1
