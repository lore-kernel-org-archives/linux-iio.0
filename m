Return-Path: <mranostay@gmail.com>
From: Matt Ranostay <mranostay@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de,
	pmeerw@pmeerw.net
Cc: linux-iio@vger.kernel.org,
	Matt Ranostay <mranostay@gmail.com>
Subject: [PATCH v2 0/1] iio: humidty: add HDC100x support
Date: Mon, 31 Aug 2015 23:39:44 -0700
Message-Id: <1441089585-26486-1-git-send-email-mranostay@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

Changes from v2:
 * Fixed incorrect byte order from measurement reading
 * Updated Kconfig and ABI documentation
 * Changed resolution data to more readable struct
 * Removed un-needed .channel assignments in hdc100x_channels
 * Fixed logic bug in heater enabling
 * Various minor changes (removing inlines, removing fall-thrus, etc)

Matt Ranostay (1):
  iio: humidity: add HDC100x support

 .../ABI/testing/sysfs-bus-iio-humidity-hdc100x     |   9 +
 drivers/iio/humidity/Kconfig                       |  10 +
 drivers/iio/humidity/Makefile                      |   1 +
 drivers/iio/humidity/hdc100x.c                     | 317 +++++++++++++++++++++
 4 files changed, 337 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-humidity-hdc100x
 create mode 100644 drivers/iio/humidity/hdc100x.c

-- 
1.9.1
