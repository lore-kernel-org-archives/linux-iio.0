Return-Path: <tiberiu.a.breana@intel.com>
From: Tiberiu Breana <tiberiu.a.breana@intel.com>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH v2 0/2] Add support for Sensortek STK3310
Date: Fri, 24 Apr 2015 16:46:37 +0300
Message-Id: <1429883199-28201-1-git-send-email-tiberiu.a.breana@intel.com>
List-ID: <linux-iio@vger.kernel.org>

These patches include an iio driver for the Sensortek STK3310
ambient light and proximity sensor. The STK3311 model is also
supported.

Datasheet:
http://www.datasheetspdf.com/datasheet/STK3310.html

Patches are as following:

1. basic functionality:
- raw readings of light and proximity data
- configuration of parameters like gain and integration time
- power management

2. interrupt support:
- interrupt support for proximity events
- enabling/disabling interrupts (events) via sysfs
- setting proximity thresholds

Changes since v1:
- addressed Jonathan's comments
- replaced devm_iio_device_register w/ iio_device_register
- merged power management patch into patch 1
- replaced the cache table with a regmap that now handles all
  parameter and interrupt configurations
- removed the set_cfg function along with enums and defines
  that were no longer needed
- fixed IT values exposed to userspace
- removed the reset_psint function and moved its functionality
  to the event handler
- added an irq_handler to capture  more accurate event timestamps

Regards,
Tiberiu


Tiberiu Breana (2):
  iio: light: Add support for Sensortek STK3310
  iio: light: Add threshold interrupt support for STK3310

 drivers/iio/light/Kconfig   |  11 +
 drivers/iio/light/Makefile  |   1 +
 drivers/iio/light/stk3310.c | 780 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 792 insertions(+)
 create mode 100644 drivers/iio/light/stk3310.c

-- 
1.9.1
