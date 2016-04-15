Return-Path: <tiberiu.a.breana@intel.com>
From: Tiberiu Breana <tiberiu.a.breana@intel.com>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 0/2] Add support for Aosong AM2315 ambient temperature & humidity sensor
Date: Fri, 15 Apr 2016 18:36:06 +0300
Message-Id: <1460734568-6306-1-git-send-email-tiberiu.a.breana@intel.com>
List-ID: <linux-iio@vger.kernel.org>

This patch set adds basic support for for Aosong AM2315 ambient
temperature & humidity sensor.
Patch 1 adds basic support, readings and ACPI detection.
Patch 2 adds triggered buffer support.

Tiberiu Breana (2):
  iio: temperature: Add support for AM2315
  iio: temperature: Add triggered buffer support for AM2315

 drivers/iio/temperature/Kconfig  |  10 ++
 drivers/iio/temperature/Makefile |   1 +
 drivers/iio/temperature/am2315.c | 293 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 304 insertions(+)
 create mode 100644 drivers/iio/temperature/am2315.c

-- 
1.9.1
