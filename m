Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailout1.w1.samsung.com ([210.118.77.11]:25284 "EHLO
	mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750708AbaKUSTk (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 21 Nov 2014 13:19:40 -0500
From: Karol Wrona <k.wrona@samsung.com>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	Karol Wrona <k.wrona@samsung.com>
Subject: [PATCH v2 0/5] misc: sensorhub: Add sensorhub driver
Date: Fri, 21 Nov 2014 19:19:12 +0100
Message-id: <1416593957-19788-1-git-send-email-k.wrona@samsung.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patchset adds support for sensorhub. It is an external mcu which
manages and collects data from several sensors i.e. on Galaxy Gear 2 watch.

It contains:
- spi driver for sensorhub device
- DT binding for the device
- IIO common utils for ssp sensors (iio kfifo setup helpers, pre/post callbacks)
- IIO accelerometer driver
- IIO gyroscope driver

For now the driver supports "traditional" sensors but new ones types are
intended to be used.

It depends on:
[PATCH v4 1/1] misc: st32fwu: Add stm32 upgrade protocol handling
which is used to firmware upgrade.

>From v1:
  - Adopted to new stm32fwu v5
  - Fixed sensors' data process callbacks
  - Fixed comments style

Karol Wrona (5):
  misc: sensorhub: Add sensorhub driver
  sensorhub: Add sensorhub bindings
  iio: sensorhub: Add sensorhub iio commons
  iio: sensorhub: Add sensorhub accelerometer sensor
  iio: sensorhub: Add sensorhub gyroscope sensor

 .../devicetree/bindings/misc/sensorhub.txt         |   46 ++
 drivers/iio/accel/Makefile                         |    2 +
 drivers/iio/accel/ssp_accel_sensor.c               |  223 ++++++
 drivers/iio/common/Kconfig                         |    1 +
 drivers/iio/common/Makefile                        |    1 +
 drivers/iio/common/ssp_sensors/Kconfig             |   13 +
 drivers/iio/common/ssp_sensors/Makefile            |    5 +
 drivers/iio/common/ssp_sensors/ssp_iio.c           |   81 ++
 drivers/iio/common/ssp_sensors/ssp_iio_sensor.h    |   59 ++
 drivers/iio/gyro/Makefile                          |    2 +
 drivers/iio/gyro/ssp_gyro_sensor.c                 |  222 ++++++
 drivers/misc/Kconfig                               |    1 +
 drivers/misc/Makefile                              |    1 +
 drivers/misc/sensorhub/Kconfig                     |   13 +
 drivers/misc/sensorhub/Makefile                    |    6 +
 drivers/misc/sensorhub/ssp.h                       |  279 +++++++
 drivers/misc/sensorhub/ssp_dev.c                   |  828 ++++++++++++++++++++
 drivers/misc/sensorhub/ssp_spi.c                   |  653 +++++++++++++++
 include/linux/iio/common/ssp_sensors.h             |   79 ++
 19 files changed, 2515 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/sensorhub.txt
 create mode 100644 drivers/iio/accel/ssp_accel_sensor.c
 create mode 100644 drivers/iio/common/ssp_sensors/Kconfig
 create mode 100644 drivers/iio/common/ssp_sensors/Makefile
 create mode 100644 drivers/iio/common/ssp_sensors/ssp_iio.c
 create mode 100644 drivers/iio/common/ssp_sensors/ssp_iio_sensor.h
 create mode 100644 drivers/iio/gyro/ssp_gyro_sensor.c
 create mode 100644 drivers/misc/sensorhub/Kconfig
 create mode 100644 drivers/misc/sensorhub/Makefile
 create mode 100644 drivers/misc/sensorhub/ssp.h
 create mode 100644 drivers/misc/sensorhub/ssp_dev.c
 create mode 100644 drivers/misc/sensorhub/ssp_spi.c
 create mode 100644 include/linux/iio/common/ssp_sensors.h

-- 
1.7.9.5

