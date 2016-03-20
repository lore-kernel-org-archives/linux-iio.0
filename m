Return-Path: <pmeerw@pmeerw.net>
From: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org
Subject: [PATCH v2 0/3] Add IIO veml6070 driver and UV light support
Date: Sun, 20 Mar 2016 16:20:21 +0100
Message-Id: <1458487224-3872-1-git-send-email-pmeerw@pmeerw.net>
List-ID: <linux-iio@vger.kernel.org>

v2 adds a new IIO channel type IIO_UVINDEX (suggested by Jonathan)

Peter Meerwald-Stadler (3):
  iio: Add modifier for UV light
  iio: Add channel for UV index
  iio: Add Vishay VEML6070 UV A light sensor driver

 Documentation/ABI/testing/sysfs-bus-iio |  13 +-
 drivers/iio/industrialio-core.c         |   2 +
 drivers/iio/light/Kconfig               |  10 ++
 drivers/iio/light/Makefile              |   1 +
 drivers/iio/light/veml6070.c            | 218 ++++++++++++++++++++++++++++++++
 include/uapi/linux/iio/types.h          |   2 +
 tools/iio/iio_event_monitor.c           |   4 +
 7 files changed, 249 insertions(+), 1 deletion(-)
 create mode 100644 drivers/iio/light/veml6070.c

-- 
1.9.1
