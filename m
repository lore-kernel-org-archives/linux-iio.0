Return-Path: <mranostay@gmail.com>
From: Matt Ranostay <mranostay@gmail.com>
To: marex@denx.de,
	matt@ohporter.com,
	pantelis.antoniou@gmail.com,
	jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	Matt Ranostay <mranostay@gmail.com>
Subject: [PATCH 0/2] iio: proximity: add PulsedLight LIDAR sensor support
Date: Fri, 31 Jul 2015 20:58:02 -0700
Message-Id: <1438401484-22101-1-git-send-email-mranostay@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

PulsedLight "blue label" v2 LIDAR sensor can be polled over 100HZ with
the sysfs + hrtimer iio trigger, or using single measurement raw measurment.

This patchset adds support for this range finding LIDAR module, and reports
distance back in meters to centimeter resolution with +/- 2.5 CM of accuracy
at ~40 meters.

Matt Ranostay (2):
  devicetree: add PulsedLight vendor prefix
  iio: proximity: add support for PulsedLight LIDAR

 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 drivers/iio/proximity/Kconfig                      |  13 +
 drivers/iio/proximity/Makefile                     |   1 +
 drivers/iio/proximity/lidar.c                      | 309 +++++++++++++++++++++
 4 files changed, 324 insertions(+)
 create mode 100644 drivers/iio/proximity/lidar.c

-- 
1.9.1
