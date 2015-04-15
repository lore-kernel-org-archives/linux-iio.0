Return-Path: <daniel.baluta@intel.com>
From: Daniel Baluta <daniel.baluta@intel.com>
To: jic23@kernel.org
Cc: knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	daniel.baluta@intel.com,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: [PATCH 0/3] Introduce support for MMC35240 magnetic sensor
Date: Wed, 15 Apr 2015 14:02:03 +0300
Message-Id: <1429095726-10055-1-git-send-email-daniel.baluta@intel.com>
List-ID: <linux-iio@vger.kernel.org>

This adds support for Memsic's MMC35240 magnetometer. The sensor does
not offer an interrupt line for data ready so for the moment we only
expose raw readings via sysfs interface.

This patchset also adds ACPI and Power Management support.

Daniel Baluta (3):
  iio: magnetometer: Add support for MEMSIC MMC35240 sensor
  iio: magnetometer: mmc35240: Add PM sleep support
  iio: magnetometer: Add ACPI support for MMC35240

 drivers/iio/magnetometer/Kconfig    |  11 +
 drivers/iio/magnetometer/Makefile   |   1 +
 drivers/iio/magnetometer/mmc35240.c | 519 ++++++++++++++++++++++++++++++++++++
 3 files changed, 531 insertions(+)
 create mode 100644 drivers/iio/magnetometer/mmc35240.c

-- 
1.9.1
