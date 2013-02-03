Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:52792 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752151Ab3BCLwi (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 3 Feb 2013 06:52:38 -0500
Message-ID: <510E4F84.2080909@kernel.org>
Date: Sun, 03 Feb 2013 11:52:36 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Greg KH <gregkh@linuxfoundation.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: [PULL] IIO cleanups, new drivers and fixes (IIO set 3 for the 3.9
 cycle)
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following changes since commit 085494ac2039433a5df9fdd6fb653579e18b8c71:

  staging: comedi: don't expose comedi_proc_{init,cleanup} (2013-01-31 10:40:41 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-3.9c

for you to fetch changes up to 6cb2afd7c0abb93bd9dc6d36b858b1e312e2407d:

  iio: Simplify iio_map_array_unregister API (2013-02-02 12:02:20 +0000)

----------------------------------------------------------------
Third set of IIO new drivers, cleanups and fixes for the 3.9 cycle

New drivers
1) A driver for ST microelectronics sensors.  This driver already covers
   a large set of new parts (20 gyros, accelerometer and magnetometers)
   not currently covered by the existing drivers.  The intent moving forward
   is to merge this with the other drivers for similar parts already in tree.
   The lis3l02dq driver currently in staging/iio will be trivial, the lis3
   driver in misc more complex as it has a number of additional interfaces.
   Any merging in of the lis3 driver will rely on the not currently
   merged iio_input bridge driver and handling of freefall notifications
   etc.

2) A driver for the itg3200 gyroscope.

Graduations from staging
1) Cleanup and move out of staging of the adxrs450 gyroscope driver.  The
   cleanup required was all minor but there were a couple of fixes hidden in
   there.

Core and driver additions
1) Initial work from Guenter Roeck on device tree support for IIO's provider/
   consumer code. Focuses on the iio_hwmon driver and the max1363 adc driver.
   The full device tree syntax is currently under discussion but should
   follow shortly.

Cleanups and fixes
1) Remove a noop function __iio_update_buffer
2) Couple of small fixes and cleanups for the max1363

----------------------------------------------------------------
Denis CIOCCA (1):
      iio:common: removed unused functions outside st_sensors library

Denis Ciocca (4):
      iio:common: Add STMicroelectronics common library
      iio:accel: Add STMicroelectronics accelerometers driver
      iio:gyro: Add STMicroelectronics gyroscopes driver
      iio:magnetometer: Add STMicroelectronics magnetometers driver

Guenter Roeck (9):
      staging/iio: (iio_hwmon) Use devm_kzalloc
      staging/iio: (iio_hwmon) Add support for sysfs name attribute
      staging/iio: (iio_hwmon) Basic devicetree support
      iio/adc: (lp8788) Provide OF node information to iio device
      iio/adc: (max1363) Provide OF node information to iio device
      iio/adc: (max1363) Remove duplicate code
      iio/adc: (max1363) Fix data conversion problems
      iio: Update iio_channel_get_all and iio_channel_get_all_cb API
      iio: Simplify iio_map_array_unregister API

Lars-Peter Clausen (12):
      staging:iio: Remove noop call to __iio_update_buffer
      Partially revert "staging:iio:gyro:adxrs450 make more use of spi_read and spi_write."
      staging:iio:adxrs450: Make transfer buffers __be32
      staging:iio:adxrs450: Perform sign extension for the calibbias register
      staging:iio:adxrs450: Reject out of range calibscale values
      staging:iio:adxrs450: Don't spam the bootlog
      staging:iio:adxrs450: Reflow overlong lines
      staging:iio:adxrs450: Don't split string across multiple lines
      staging:iio:adxrs450: Use usleep_range for the sequential transfer dealy
      staging:iio:adxrs450: Fixup kernel doc comments
      staging:iio:adxrs450: Move header file contents to main file
      staging:iio: Move adxrs450 driver out of staging

Manuel Stahl (1):
      iio: gyro: Add itg3200

 drivers/iio/accel/Kconfig                          |  31 ++
 drivers/iio/accel/Makefile                         |   8 +
 drivers/iio/accel/st_accel.h                       |  47 ++
 drivers/iio/accel/st_accel_buffer.c                | 114 +++++
 drivers/iio/accel/st_accel_core.c                  | 495 +++++++++++++++++++++
 drivers/iio/accel/st_accel_i2c.c                   |  87 ++++
 drivers/iio/accel/st_accel_spi.c                   |  86 ++++
 drivers/iio/adc/lp8788_adc.c                       |  12 +-
 drivers/iio/adc/max1363.c                          |  12 +-
 drivers/iio/buffer_cb.c                            |   4 +-
 drivers/iio/common/Kconfig                         |   1 +
 drivers/iio/common/Makefile                        |   1 +
 drivers/iio/common/st_sensors/Kconfig              |  14 +
 drivers/iio/common/st_sensors/Makefile             |  10 +
 drivers/iio/common/st_sensors/st_sensors_buffer.c  | 116 +++++
 drivers/iio/common/st_sensors/st_sensors_core.c    | 446 +++++++++++++++++++
 drivers/iio/common/st_sensors/st_sensors_i2c.c     |  81 ++++
 drivers/iio/common/st_sensors/st_sensors_spi.c     | 128 ++++++
 drivers/iio/common/st_sensors/st_sensors_trigger.c |  77 ++++
 drivers/iio/gyro/Kconfig                           |  48 ++
 drivers/iio/gyro/Makefile                          |  13 +
 .../gyro/adxrs450_core.c => iio/gyro/adxrs450.c}   | 197 +++++---
 drivers/iio/gyro/itg3200_buffer.c                  | 156 +++++++
 drivers/iio/gyro/itg3200_core.c                    | 401 +++++++++++++++++
 drivers/iio/gyro/st_gyro.h                         |  45 ++
 drivers/iio/gyro/st_gyro_buffer.c                  | 114 +++++
 drivers/iio/gyro/st_gyro_core.c                    | 363 +++++++++++++++
 drivers/iio/gyro/st_gyro_i2c.c                     |  85 ++++
 drivers/iio/gyro/st_gyro_spi.c                     |  84 ++++
 drivers/iio/inkern.c                               |  42 +-
 drivers/iio/kfifo_buf.c                            |   1 -
 drivers/iio/magnetometer/Kconfig                   |  30 ++
 drivers/iio/magnetometer/Makefile                  |   7 +
 drivers/iio/magnetometer/st_magn.h                 |  45 ++
 drivers/iio/magnetometer/st_magn_buffer.c          |  98 ++++
 drivers/iio/magnetometer/st_magn_core.c            | 401 +++++++++++++++++
 drivers/iio/magnetometer/st_magn_i2c.c             |  81 ++++
 drivers/iio/magnetometer/st_magn_spi.c             |  80 ++++
 drivers/staging/iio/gyro/Kconfig                   |  10 -
 drivers/staging/iio/gyro/Makefile                  |   3 -
 drivers/staging/iio/gyro/adxrs450.h                |  62 ---
 drivers/staging/iio/iio_hwmon.c                    |  83 ++--
 include/linux/iio/buffer.h                         |  13 -
 include/linux/iio/common/st_sensors.h              | 270 +++++++++++
 include/linux/iio/common/st_sensors_i2c.h          |  20 +
 include/linux/iio/common/st_sensors_spi.h          |  20 +
 include/linux/iio/consumer.h                       |   9 +-
 include/linux/iio/driver.h                         |   9 +-
 include/linux/iio/gyro/itg3200.h                   | 154 +++++++
 49 files changed, 4455 insertions(+), 259 deletions(-)
 create mode 100644 drivers/iio/accel/st_accel.h
 create mode 100644 drivers/iio/accel/st_accel_buffer.c
 create mode 100644 drivers/iio/accel/st_accel_core.c
 create mode 100644 drivers/iio/accel/st_accel_i2c.c
 create mode 100644 drivers/iio/accel/st_accel_spi.c
 create mode 100644 drivers/iio/common/st_sensors/Kconfig
 create mode 100644 drivers/iio/common/st_sensors/Makefile
 create mode 100644 drivers/iio/common/st_sensors/st_sensors_buffer.c
 create mode 100644 drivers/iio/common/st_sensors/st_sensors_core.c
 create mode 100644 drivers/iio/common/st_sensors/st_sensors_i2c.c
 create mode 100644 drivers/iio/common/st_sensors/st_sensors_spi.c
 create mode 100644 drivers/iio/common/st_sensors/st_sensors_trigger.c
 rename drivers/{staging/iio/gyro/adxrs450_core.c => iio/gyro/adxrs450.c} (68%)
 create mode 100644 drivers/iio/gyro/itg3200_buffer.c
 create mode 100644 drivers/iio/gyro/itg3200_core.c
 create mode 100644 drivers/iio/gyro/st_gyro.h
 create mode 100644 drivers/iio/gyro/st_gyro_buffer.c
 create mode 100644 drivers/iio/gyro/st_gyro_core.c
 create mode 100644 drivers/iio/gyro/st_gyro_i2c.c
 create mode 100644 drivers/iio/gyro/st_gyro_spi.c
 create mode 100644 drivers/iio/magnetometer/st_magn.h
 create mode 100644 drivers/iio/magnetometer/st_magn_buffer.c
 create mode 100644 drivers/iio/magnetometer/st_magn_core.c
 create mode 100644 drivers/iio/magnetometer/st_magn_i2c.c
 create mode 100644 drivers/iio/magnetometer/st_magn_spi.c
 delete mode 100644 drivers/staging/iio/gyro/adxrs450.h
 create mode 100644 include/linux/iio/common/st_sensors.h
 create mode 100644 include/linux/iio/common/st_sensors_i2c.h
 create mode 100644 include/linux/iio/common/st_sensors_spi.h
 create mode 100644 include/linux/iio/gyro/itg3200.h
