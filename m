Return-Path: <tiberiu.a.breana@intel.com>
From: Tiberiu Breana <tiberiu.a.breana@intel.com>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH v3 0/2] Add support for Sensortek STK3310
Date: Mon, 27 Apr 2015 18:33:59 +0300
Message-Id: <1430148841-30947-1-git-send-email-tiberiu.a.breana@intel.com>
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

Changes since v2:
- addressed Peter's comments
- changed integration_time_available's type to IIO_CONST_ATTR
- added scale_available attribute for proximity
- removed the stk3310_get_it_vals function
- added the STK3310_REGFIELD macro to reduce source code size

Regards,
Tiberiu

Tiberiu Breana (2):
  iio: light: Add support for Sensortek STK3310
  iio: light: Add threshold interrupt support for STK3310

 drivers/iio/light/Kconfig   |  11 +
 drivers/iio/light/Makefile  |   1 +
 drivers/iio/light/stk3310.c | 722 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 734 insertions(+)
 create mode 100644 drivers/iio/light/stk3310.c

-- 
1.9.1
