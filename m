Return-Path: <mranostay@gmail.com>
From: Matt Ranostay <mranostay@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	Matt Ranostay <mranostay@gmail.com>
Subject: [PATCH 0/2] iio: humidity: sht31: add Sensirion SHT31 support
Date: Sat, 11 Jun 2016 22:13:15 -0700
Message-Id: <1465708397-19649-1-git-send-email-mranostay@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

Add support for the humidity and temperature functionally for the SHT31
chipset. In addition add support for using using software triggers.

Matt Ranostay (2):
  devicetree: add Sensirion AG vendor id
  iio: humidity: sht31: add Sensirion SHT31 support

 .../devicetree/bindings/i2c/trivial-devices.txt    |   1 +
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 drivers/iio/humidity/Kconfig                       |  11 +
 drivers/iio/humidity/Makefile                      |   1 +
 drivers/iio/humidity/sht31.c                       | 416 +++++++++++++++++++++
 5 files changed, 430 insertions(+)
 create mode 100644 drivers/iio/humidity/sht31.c

-- 
2.7.4
