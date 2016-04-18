Return-Path: <tiberiu.a.breana@intel.com>
From: Tiberiu Breana <tiberiu.a.breana@intel.com>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: [PATCH v3 0/2] Add support for Aosong AM2315 relative humidity and ambient temperature sensor
Date: Mon, 18 Apr 2016 17:50:42 +0300
Message-Id: <1460991044-8484-1-git-send-email-tiberiu.a.breana@intel.com>
List-ID: <linux-iio@vger.kernel.org>

This patch set adds basic support for the Aosong AM2315 relative
humidity and ambient temperature sensor.

Patch 1 adds basic support, raw readings and ACPI detection.
Patch 2 adds triggered buffer support.
---
v3 change log:

patch 1/2:
- addressed Peter's comments
- added a mutex for the read_data sequence
- added the am2315_sensor_data struct to better abstract data acquisition

patch 2/2:
no changes
---
v2 change log:

patch 1/2:
- moved driver from iio/temperature to iio/humidity
- addressed Jonathan's comments
- fixed scale to export values in millipercent (humidity) and
  millidegrees (temperature)

patch 2/2:
no changes
---
Tiberiu Breana (2):
  iio: humidity: Add support for AM2315
  iio: humidity: Add triggered buffer support for AM2315

 drivers/iio/humidity/Kconfig  |  10 ++
 drivers/iio/humidity/Makefile |   1 +
 drivers/iio/humidity/am2315.c | 303 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 314 insertions(+)
 create mode 100644 drivers/iio/humidity/am2315.c

-- 
1.9.1
