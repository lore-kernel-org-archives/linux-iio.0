Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailout1.w1.samsung.com ([210.118.77.11]:64644 "EHLO
	mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753755Ab3I0QcY (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 27 Sep 2013 12:32:24 -0400
From: Lukasz Czerwinski <l.czerwinski@samsung.com>
To: jic23@cam.ac.uk
Cc: denis.ciocca@st.com, linux-iio@vger.kernel.org,
	lee.jones@linaro.org, devicetree@vger.kernel.org
Subject: [RFC v2 PATCH 00/14]  iio: STMicroelectronics DT and event support
Date: Fri, 27 Sep 2013 18:32:04 +0200
Message-id: <1380299538-22047-1-git-send-email-l.czerwinski@samsung.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi,

This is the second version the patchset that adds device tree and event
subsystem support for generic st_common library.

I tested my patches with Exynos4x12 board with device tree.
I tested sensor LSM330DLC (accelerometer and gyroscope).
Triggered buffer and events were tested separately for each sensor.
Generally it works fine.

I couldn't implement event patch for lsm330dlc gyroscope because I
don't have connected gyroscope INT1 pin to SoC.

My implementation allows to use event system or triggered buffer by
proper declaration of irqs in device tree/platform data.

This is a follow-up of the previous patch and it includes
following improvements (Jonathan thanks for the review):
 - new dt bindings, modified according to the suggestions from the thread
	http://www.spinics.net/lists/linux-iio/msg09646.html
 - add missing EXPORT_SYMBOL
 - remove write to const channel specs in st_accel
 - add global flag which enables event interface to the st_sensors struct
 - corrected various minor bits and bobs

Comments are welcome.

[1] - http://www.spinics.net/lists/linux-iio/msg08883.html

Thanks
Lukasz

Lukasz Czerwinski (14):
  iio: st_common: New interrupt interface
  iio: st_accel: Add dt bindings
  iio: st_gyro: Add dt bindings
  iio: st_mang: Add dt bindings
  iio: st_pressure: Add dt bindings
  iio: st_common: Add threshold events support
  iio: st_accel: Add event subsystem to st_accel driver
  iio: iio_magn: Add event ops
  iio: st_gyro: Add event ops
  iio: iio_press: Add event ops
  Documentation: Add st_magn binding documentation
  Documentation: Add st_gyro binding documentation
  Documentation: Add st_pressure binding documentation
  Documentation: Add st_accel binding documentation

 .../iio/accelerometer/st_accelerometer.txt         |   40 ++++
 .../bindings/iio/barometer/st_barometer.txt        |   38 +++
 .../bindings/iio/gyroscope/st_gyroscope.txt        |   38 +++
 .../bindings/iio/magnetometer/st_magnometer.txt    |   33 +++
 drivers/iio/accel/st_accel.h                       |   19 +-
 drivers/iio/accel/st_accel_core.c                  |  106 ++++++++-
 drivers/iio/accel/st_accel_i2c.c                   |   19 +-
 drivers/iio/accel/st_accel_spi.c                   |   19 +-
 drivers/iio/common/st_sensors/st_sensors_core.c    |  245 +++++++++++++++++---
 drivers/iio/common/st_sensors/st_sensors_i2c.c     |   75 +++++-
 drivers/iio/common/st_sensors/st_sensors_spi.c     |   77 +++++-
 drivers/iio/gyro/st_gyro.h                         |   15 +-
 drivers/iio/gyro/st_gyro_core.c                    |   12 +-
 drivers/iio/gyro/st_gyro_i2c.c                     |   18 +-
 drivers/iio/gyro/st_gyro_spi.c                     |   18 +-
 drivers/iio/magnetometer/st_magn.h                 |    3 +-
 drivers/iio/magnetometer/st_magn_core.c            |    9 +-
 drivers/iio/magnetometer/st_magn_i2c.c             |   12 +-
 drivers/iio/magnetometer/st_magn_spi.c             |   12 +-
 drivers/iio/pressure/st_pressure.h                 |    3 +-
 drivers/iio/pressure/st_pressure_core.c            |   14 +-
 drivers/iio/pressure/st_pressure_i2c.c             |   11 +-
 drivers/iio/pressure/st_pressure_spi.c             |   11 +-
 include/linux/iio/common/st_sensors.h              |   87 ++++++-
 include/linux/platform_data/st_sensors_pdata.h     |    2 +
 25 files changed, 836 insertions(+), 100 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/accelerometer/st_accelerometer.txt
 create mode 100644 Documentation/devicetree/bindings/iio/barometer/st_barometer.txt
 create mode 100644 Documentation/devicetree/bindings/iio/gyroscope/st_gyroscope.txt
 create mode 100644 Documentation/devicetree/bindings/iio/magnetometer/st_magnometer.txt

-- 
1.7.9.5

