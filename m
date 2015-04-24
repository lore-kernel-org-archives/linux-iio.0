Return-Path: <daniel.baluta@intel.com>
From: Daniel Baluta <daniel.baluta@intel.com>
To: jic23@kernel.org,
	pmeerw@pmeerw.net
Cc: knaack.h@gmx.de,
	lars@metafoo.de,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	daniel.baluta@intel.com
Subject: [PATCH v2 0/3] Introduce support for MMC35240 magnetic sensor
Date: Fri, 24 Apr 2015 18:58:29 +0300
Message-Id: <1429891112-11888-1-git-send-email-daniel.baluta@intel.com>
List-ID: <linux-iio@vger.kernel.org>

This adds support for Memsic's MMC35240 magnetometer. The sensor does
not offer an interrupt line for data ready so for the moment we only
expose raw readings via sysfs interface.

This patchset also adds ACPI and Power Management support.

Changes since v1:
	* fixed nits reported by Peter and Jonathan
	* https://lkml.org/lkml/2015/4/15/186

Daniel Baluta (3):
  iio: magnetometer: Add support for MEMSIC MMC35240 sensor
  iio: magnetometer: mmc35240: Add PM sleep support
  iio: magnetometer: Add ACPI support for MMC35240

 drivers/iio/magnetometer/Kconfig    |  11 +
 drivers/iio/magnetometer/Makefile   |   1 +
 drivers/iio/magnetometer/mmc35240.c | 511 ++++++++++++++++++++++++++++++++++++
 3 files changed, 523 insertions(+)
 create mode 100644 drivers/iio/magnetometer/mmc35240.c

-- 
1.9.1
