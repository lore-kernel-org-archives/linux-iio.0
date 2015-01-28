Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailout3.w1.samsung.com ([210.118.77.13]:42365 "EHLO
	mailout3.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755341AbbA1UQx (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 28 Jan 2015 15:16:53 -0500
From: Karol Wrona <k.wrona@samsung.com>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	Karol Wrona <wrona.vy@gmail.com>,
	Karol Wrona <k.wrona@samsung.com>
Subject: [PATCH v5 0/5] iio: Add sensorhub driver
Date: Wed, 28 Jan 2015 15:05:49 +0100
Message-id: <1422453954-27317-1-git-send-email-k.wrona@samsung.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hello,

This patchset adds support for sensorhub.  It is an external mcu which
manages and collects data from several sensors i.e. on Galaxy Gear 2 watch.

It contains:
- spi driver for sensorhub device
- DT binding for the device
- IIO common utils for ssp sensors (iio kfifo setup helpers, pre/post callbacks)
- IIO accelerometer driver
- IIO gyroscope driver

For now the driver supports "traditional" sensors but new ones types are
intended to be used.

The patchset depends on INDIO_BUFFER_SOFTWARE adding patch.

>From v1:
  - Adopted to new stm32fwu v5
  - Fixed sensors' data process callbacks
  - Fixed comments style

>From v2:
  - Fixes after Hartmut Knaack review
  - Sensorhub driver was moved from misc to iio after the discussion with Arnd
    and Jonathan
  - Firmware upgrade is not supported in this patchset. I hope it will be
    applied when it will find its own place in the tree.

>From v3:
  - change buffer allocation manner for iio devices buffers
  - centralize irq buffer
  - style fixes
  - sensors' devices as mfd cells
  - remove iio_buffer_register from the sensorhub drivers
  - fix DT binding and remove optional attributes

>From v4:
  - fix Kconfig - missing MFD_CORE dependency
  - rebase on next-20150128
  - remove THIS_MODULE usage in sensors' drivers as not needed


Thanks,
Karol


Karol Wrona (5):
  iio: common: ssp_sensors: Add sensorhub driver
  iio: sensorhub: Add sensorhub bindings
  iio: common: ssp_sensors: Add sensorhub iio commons
  iio: common: ssp_sensors: Add sensorhub accelerometer sensor
  iio: common: ssp_sensors: Add sensorhub gyroscope sensor

 .../devicetree/bindings/iio/sensorhub.txt          |   25 +
 drivers/iio/accel/Makefile                         |    1 +
 drivers/iio/accel/ssp_accel_sensor.c               |  169 +++++
 drivers/iio/common/Kconfig                         |    1 +
 drivers/iio/common/Makefile                        |    1 +
 drivers/iio/common/ssp_sensors/Kconfig             |   26 +
 drivers/iio/common/ssp_sensors/Makefile            |    8 +
 drivers/iio/common/ssp_sensors/ssp.h               |  257 +++++++
 drivers/iio/common/ssp_sensors/ssp_dev.c           |  712 ++++++++++++++++++++
 drivers/iio/common/ssp_sensors/ssp_iio.c           |  107 +++
 drivers/iio/common/ssp_sensors/ssp_iio_sensor.h    |   70 ++
 drivers/iio/common/ssp_sensors/ssp_spi.c           |  608 +++++++++++++++++
 drivers/iio/gyro/Makefile                          |    2 +
 drivers/iio/gyro/ssp_gyro_sensor.c                 |  168 +++++
 include/linux/iio/common/ssp_sensors.h             |   82 +++
 15 files changed, 2237 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/sensorhub.txt
 create mode 100644 drivers/iio/accel/ssp_accel_sensor.c
 create mode 100644 drivers/iio/common/ssp_sensors/Kconfig
 create mode 100644 drivers/iio/common/ssp_sensors/Makefile
 create mode 100644 drivers/iio/common/ssp_sensors/ssp.h
 create mode 100644 drivers/iio/common/ssp_sensors/ssp_dev.c
 create mode 100644 drivers/iio/common/ssp_sensors/ssp_iio.c
 create mode 100644 drivers/iio/common/ssp_sensors/ssp_iio_sensor.h
 create mode 100644 drivers/iio/common/ssp_sensors/ssp_spi.c
 create mode 100644 drivers/iio/gyro/ssp_gyro_sensor.c
 create mode 100644 include/linux/iio/common/ssp_sensors.h

-- 
1.7.9.5

