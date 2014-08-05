Return-Path: <srinivas.pandruvada@linux.intel.com>
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v3 0/2] iio: accel: BMC150 accel support
Date: Tue,  5 Aug 2014 14:57:03 -0700
Message-Id: <1407275825-29035-1-git-send-email-srinivas.pandruvada@linux.intel.com>
List-ID: <linux-iio@vger.kernel.org>

v3
- Suport Only Runtime PM no fallback method. Driver will still work but
chip will be in power on mode.
- Add comment for enable disable trigger/event sequence, how they work
in reverse order using runtime pm calls

v2
Fix compile issue with RUNTIME PM is not defined

v1
Format of this driver is similar to BMG160 gyro as the register
style for configuration is similar, but not same
- Any motion trigger as suggested similar to BMG160 gyro
- Formatting issues suggested during v0 review
- Addition of TEMP
- Run Time PM with auto suspend

v0
Basic version for review

Srinivas Pandruvada (2):
  iio: accel: BMC150 accel support
  iio: accel: BMC150 accel documentation

 .../ABI/testing/sysfs-bus-iio-accel-bmc150         |    7 +
 drivers/iio/accel/Kconfig                          |   13 +
 drivers/iio/accel/Makefile                         |    1 +
 drivers/iio/accel/bmc150-accel.c                   | 1307 ++++++++++++++++++++
 4 files changed, 1328 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-accel-bmc150
 create mode 100644 drivers/iio/accel/bmc150-accel.c

-- 
1.7.11.7
