Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:54073 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755737Ab2KUTOW (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 21 Nov 2012 14:14:22 -0500
Message-ID: <50AD280B.7050904@kernel.org>
Date: Wed, 21 Nov 2012 19:14:19 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Greg KH <gregkh@linuxfoundation.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: [PULL]  IIO cleanups, new drivers and fixes (IIO set 5 for the 3.8
 cycle)
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following changes since commit acf1cf6a1c0966ef64a73083ca985605a12b032d:

  Merge 3.7-rc6 into staging-next (2012-11-16 18:24:22 -0800)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-3.8e

for you to fetch changes up to be7fd3b86ad2f2a8db58decc15d2274b0c89c23b:

  iio:adc:ad7298 make the tx and rx buffers __be16 (2012-11-21 18:24:26 +0000)

----------------------------------------------------------------
Fifth round of new IIO drivers, cleanups and fixes for the 3.8 cycle.

Here we have a number of minor fixes.
* a quirk for the hid sensor driver should be a boolean option.
* return an error for a failed memdup in the hid sensor driver.
* Fix a return value in adt7410.
* A double free in the IIO event infrastructure.
* Disabling interrupts in tsl2563 was wrong (never been correct!)
* Incorrect signature for the iio_buffer_register stub
* Incorrect return for isl29018 write_raw callback.
* A number of minor fixes as part of the various rework series.

New drivers and major rework.
* Introduce and use extensively an adis library for numerous spi
  Analog Devices mems sensors.  This then moves out of staging.
* Lots of new stuff then added to this library to support newer
  sensors.
* New drivers for ADIS16136 and ADIS16480 and similar.
* Core support for barometric pressure sensors.
* ad7298 cleanup and move out of staging.

The bulk of this is from Lars-Peter Clausen.  He's been rather
busy!

----------------------------------------------------------------
Axel Lin (1):
      iio: hid-sensor: Return proper error if kmemdup fails

Derek Basehore (1):
      tsl2563: fixed bug with disabling interrupts

Jonathan Cameron (1):
      iio:adc:ad7298 make the tx and rx buffers __be16

Julia Lawall (1):
      drivers/iio/industrialio-event.c: eliminate possible double free

Kirill A. Shutemov (1):
      iio: hid-sensors: convert HID_SENSOR_ENUM_BASE_QUIRKS to bool

Lars-Peter Clausen (25):
      staging:iio:adt7410: Fix adt7410_set_mode return value
      iio: Fix iio_buffer_register stub signature
      staging:iio: Add common ADIS library
      staging:iio:adis16201: Use adis library
      staging:iio:adis16203: Use adis library
      staging:iio:adis16204: Use adis library
      staging:iio:adis16209: Use adis library
      staging:iio:adis16220: Use adis library
      staging:iio:adis16240: Use adis library
      staging:iio:adis16260: Use adis library
      staging:iio:adis_lib: Use triggered buffer setup helper function
      staging:iio:adis: Preallocate transfer message
      staging:iio: Move adis library out of staging
      staging:iio:ad7298: Do not perform endianness conversion in buffered mode
      staging:iio:ad7298: Rework regulator handling
      staging:iio:ad7298: Fix temperature scale and offset
      staging:iio:ad7298: Squash everything into one file
      staging:iio: Move the ad7298 driver out of staging
      iio:imu:adis: Add debugfs register access support
      iio:imu:adis: Add support for 32bit registers
      iio:gyro: Add support for the ADIS16136 gyroscope
      iio:imu:adis: Add paging support
      iio: Add pressure channel type
      iio: Factor out fixed point number parsing into its own function
      iio:imu: Add support for the ADIS16480 and similar IMUs

Wei Yongjun (1):
      iio: isl29018: fix to return error or 0 in isl29018_write_raw()

 Documentation/ABI/testing/sysfs-bus-iio            |  24 +
 drivers/iio/Kconfig                                |   7 +-
 drivers/iio/Makefile                               |   7 +-
 drivers/iio/accel/hid-sensor-accel-3d.c            |   6 +-
 drivers/iio/adc/Kconfig                            |  12 +
 drivers/iio/adc/Makefile                           |   1 +
 .../iio/adc/ad7298_core.c => iio/adc/ad7298.c}     | 201 ++++-
 drivers/iio/common/hid-sensors/Kconfig             |   2 +-
 .../iio/common/hid-sensors/hid-sensor-trigger.c    |   6 +-
 drivers/iio/gyro/Kconfig                           |   9 +
 drivers/iio/gyro/Makefile                          |   1 +
 drivers/iio/gyro/adis16136.c                       | 581 +++++++++++++
 drivers/iio/gyro/hid-sensor-gyro-3d.c              |   6 +-
 drivers/iio/imu/Kconfig                            |  27 +
 drivers/iio/imu/Makefile                           |  10 +
 drivers/iio/imu/adis.c                             | 440 ++++++++++
 drivers/iio/imu/adis16480.c                        | 925 +++++++++++++++++++++
 drivers/iio/imu/adis_buffer.c                      | 176 ++++
 drivers/iio/imu/adis_trigger.c                     |  89 ++
 drivers/iio/industrialio-core.c                    |  99 ++-
 drivers/iio/industrialio-event.c                   |   7 +-
 drivers/iio/light/hid-sensor-als.c                 |   5 +-
 drivers/iio/magnetometer/hid-sensor-magn-3d.c      |   6 +-
 drivers/staging/iio/accel/Kconfig                  |  21 +-
 drivers/staging/iio/accel/Makefile                 |   5 -
 drivers/staging/iio/accel/adis16201.h              |  89 +-
 drivers/staging/iio/accel/adis16201_core.c         | 466 ++---------
 drivers/staging/iio/accel/adis16201_ring.c         | 136 ---
 drivers/staging/iio/accel/adis16201_trigger.c      |  71 --
 drivers/staging/iio/accel/adis16203.h              |  80 +-
 drivers/staging/iio/accel/adis16203_core.c         | 426 ++--------
 drivers/staging/iio/accel/adis16203_ring.c         | 136 ---
 drivers/staging/iio/accel/adis16203_trigger.c      |  73 --
 drivers/staging/iio/accel/adis16204.h              |  79 +-
 drivers/staging/iio/accel/adis16204_core.c         | 452 ++--------
 drivers/staging/iio/accel/adis16204_ring.c         | 134 ---
 drivers/staging/iio/accel/adis16204_trigger.c      |  73 --
 drivers/staging/iio/accel/adis16209.h              |  77 +-
 drivers/staging/iio/accel/adis16209_core.c         | 484 ++---------
 drivers/staging/iio/accel/adis16209_ring.c         | 134 ---
 drivers/staging/iio/accel/adis16209_trigger.c      |  72 --
 drivers/staging/iio/accel/adis16220.h              |  20 +-
 drivers/staging/iio/accel/adis16220_core.c         | 280 ++-----
 drivers/staging/iio/accel/adis16240.h              |  85 +-
 drivers/staging/iio/accel/adis16240_core.c         | 473 ++---------
 drivers/staging/iio/accel/adis16240_ring.c         | 132 ---
 drivers/staging/iio/accel/adis16240_trigger.c      |  73 --
 drivers/staging/iio/adc/Kconfig                    |  11 -
 drivers/staging/iio/adc/Makefile                   |   4 -
 drivers/staging/iio/adc/ad7298.h                   |  75 --
 drivers/staging/iio/adc/ad7298_ring.c              | 113 ---
 drivers/staging/iio/adc/adt7410.c                  |   2 +-
 drivers/staging/iio/gyro/Makefile                  |   1 -
 drivers/staging/iio/gyro/adis16260.h               |  84 +-
 drivers/staging/iio/gyro/adis16260_core.c          | 484 ++---------
 drivers/staging/iio/gyro/adis16260_ring.c          | 136 ---
 drivers/staging/iio/gyro/adis16260_trigger.c       |  75 --
 drivers/staging/iio/light/isl29018.c               |   2 +-
 drivers/staging/iio/light/tsl2563.c                |   4 +-
 include/linux/iio/buffer.h                         |   2 +-
 include/linux/iio/iio.h                            |   3 +
 include/linux/iio/imu/adis.h                       | 280 +++++++
 include/linux/iio/types.h                          |   1 +
 include/linux/platform_data/ad7298.h               |  20 +
 64 files changed, 3366 insertions(+), 4649 deletions(-)
 rename drivers/{staging/iio/adc/ad7298_core.c => iio/adc/ad7298.c} (55%)
 create mode 100644 drivers/iio/gyro/adis16136.c
 create mode 100644 drivers/iio/imu/Kconfig
 create mode 100644 drivers/iio/imu/Makefile
 create mode 100644 drivers/iio/imu/adis.c
 create mode 100644 drivers/iio/imu/adis16480.c
 create mode 100644 drivers/iio/imu/adis_buffer.c
 create mode 100644 drivers/iio/imu/adis_trigger.c
 delete mode 100644 drivers/staging/iio/accel/adis16201_ring.c
 delete mode 100644 drivers/staging/iio/accel/adis16201_trigger.c
 delete mode 100644 drivers/staging/iio/accel/adis16203_ring.c
 delete mode 100644 drivers/staging/iio/accel/adis16203_trigger.c
 delete mode 100644 drivers/staging/iio/accel/adis16204_ring.c
 delete mode 100644 drivers/staging/iio/accel/adis16204_trigger.c
 delete mode 100644 drivers/staging/iio/accel/adis16209_ring.c
 delete mode 100644 drivers/staging/iio/accel/adis16209_trigger.c
 delete mode 100644 drivers/staging/iio/accel/adis16240_ring.c
 delete mode 100644 drivers/staging/iio/accel/adis16240_trigger.c
 delete mode 100644 drivers/staging/iio/adc/ad7298.h
 delete mode 100644 drivers/staging/iio/adc/ad7298_ring.c
 delete mode 100644 drivers/staging/iio/gyro/adis16260_ring.c
 delete mode 100644 drivers/staging/iio/gyro/adis16260_trigger.c
 create mode 100644 include/linux/iio/imu/adis.h
 create mode 100644 include/linux/platform_data/ad7298.h
