Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:34900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965129AbeFYUpR (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 25 Jun 2018 16:45:17 -0400
Date: Mon, 25 Jun 2018 21:45:13 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: gregkh@linuxfoundation.org, linux-iio@vger.kernel.org
Subject: [PULL] First set of new device support, features and cleanup for
 IIO in the 4.19 cycle
Message-ID: <20180625214513.3f2ddbd7@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following changes since commit 3ca24ce9ff764bc27bceb9b2fd8ece74846c3fd3:

  Merge branch 'proc-cmdline' (2018-06-09 15:31:35 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-4.19a

for you to fetch changes up to 6794e23fa3fed82b1e71f730359618b40cbf7d66:

  iio: adc: at91-sama5d2_adc: add support for oversampling resolution (2018-06-25 21:05:22 +0100)

----------------------------------------------------------------
First set of IIO new device support, features and cleanups in the 4.19 cycle

The usual mixed bunch.  Particular good to see is the generic
touch screen driver.  Will be interesting to see if this works
for other ADCs without major changes.

Core features
* Channel types
  - New position relative channel type primarily for touch screen
    sensors to feed the generic touchscreen driver.

New device support
* ad5586
  - Add support for the AD5311R DAC.

* Generic touch screen driver as an IIO consumer.
  - Note this is in input, but due to dependencies is coming through
    the IIO tree.
  - Specific support for this added to the at91-sama5d2 ADC.
  - Various necessary DT bindings added.

Staging Drops
* ADIS16060 gyro
  - A device with a very odd interface that was never cleanly supported.
    It's now very difficult to get, so unlikely it'll ever be fixed up.

Cleanups and minor features and fixes
* core
  - Fix y2038 timestamp issues now the core support is in place.
* 104-quad-8
  - Provide some defines for magic numbers to help readability.
  - Fix an off by one error in register selection
* ad7606
  - Put in a missing function parameter name in a prototype.
* adis16023
  - Use generic sign_extend function rather than local version.
* adis16240
  - Use generic sign_extend funciton rather than local version.
* at91-sama5d2
  - Drop dependency on HAS_DMA now this is handled elsewhere.  Will
    improve build test coverage.
  - Add oversampling ratio control.  Note there is a minor ABI change
    here to increase the apparent depth to 14 bits so as to allow
    for transparent provision of different oversampling ratios that
    drop the actual bit depth to 13 or 12 bits.
* hx711
  - Add a MAINTAINERS entry for this device.
* inv_mpu6050
  - Replace the timestamp fifo 'special' code with generic timestamp
    handling.
  - Switch to using local store of timestamp divider rather than rate
    as that is more helpful for accurate time measurement.
  - Fix an unaligned access that didn't seem to be causing any trouble.
  - Use the fifo overflow bit to track the overflow status rather than
    a software counter.
  - New timestamping mechanism to deal with missed sample interrupts.
* stm32-adc
  - Drop HAS_DMA build dependency.
* sun4i-gpadc
  - Select REGMAP_IRQ a very rarely hit build issue fix.

----------------------------------------------------------------
Andreas Klinger (1):
      iio: hx711: add maintainer for driver

Arnd Bergmann (2):
      iio: adc: sun4i-gpadc: select REGMAP_IRQ
      iio: use timespec64 based interfaces for iio_get_time_ns()

Eugen Hristev (8):
      MAINTAINERS: add generic resistive touchscreen adc
      iio: Add channel for Position Relative
      dt-bindings: input: touchscreen: add minimum pressure touchscreen property
      dt-bindings: input: touchscreen: resistive-adc-touch: create bindings
      iio: adc: at91-sama5d2_adc: add support for position and pressure channels
      input: touchscreen: resistive-adc-touch: add generic resistive ADC touchscreen
      dt-bindings: iio: adc: at91-sama5d2_adc: add channel specific consumer info
      iio: adc: at91-sama5d2_adc: add support for oversampling resolution

Geert Uytterhoeven (1):
      iio: adc: Remove depends on HAS_DMA in case of platform dependency

Giulio Benetti (1):
      staging: iio: adc: ad7606: fix function pointer parameter names missing.

Jean-Baptiste Maneyrol (5):
      iio: imu: inv_mpu6050: replace timestamp fifo by generic timestamp
      iio: imu: inv_mpu6050: switch to use sample rate divider
      iio: imu: inv_mpu6050: fix fifo count reading
      iio: imu: inv_mpu6050: better fifo overflow handling
      iio: imu: inv_mpu6050: new timestamp mechanism

Jonathan Cameron (1):
      staging: iio: Drop ADIS16060 driver from staging

Karim Eshapa (2):
      staging:iio:accel:adis16203: sign extend function rather code duplication
      staging:iio:accel:adis16240: sign extend function replace hard code duplication

Stefan Popa (1):
      iio:dac:ad5686: Add AD5311R support

William Breathitt Gray (2):
      iio: 104-quad-8: Fix off-by-one error in register selection
      iio: 104-quad-8: Provide defines for magic numbers

 Documentation/ABI/testing/sysfs-bus-iio            |  12 +
 .../bindings/iio/adc/at91-sama5d2_adc.txt          |   9 +
 .../input/touchscreen/resistive-adc-touch.txt      |  30 +
 .../bindings/input/touchscreen/touchscreen.txt     |   3 +
 MAINTAINERS                                        |  13 +
 drivers/iio/adc/Kconfig                            |   3 +-
 drivers/iio/adc/at91-sama5d2_adc.c                 | 780 +++++++++++++++++++--
 drivers/iio/counter/104-quad-8.c                   |  87 ++-
 drivers/iio/dac/ad5686.c                           |   7 +
 drivers/iio/dac/ad5686.h                           |   1 +
 drivers/iio/dac/ad5696-i2c.c                       |   1 +
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c         |  31 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h          |  36 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c         | 143 ++--
 drivers/iio/industrialio-core.c                    |  27 +-
 drivers/input/touchscreen/Kconfig                  |  13 +
 drivers/input/touchscreen/Makefile                 |   1 +
 drivers/input/touchscreen/resistive-adc-touch.c    | 204 ++++++
 drivers/staging/iio/Kconfig                        |   1 -
 drivers/staging/iio/Makefile                       |   1 -
 drivers/staging/iio/accel/adis16203.c              |   6 +-
 drivers/staging/iio/accel/adis16240.c              |  11 +-
 drivers/staging/iio/adc/ad7606.h                   |   2 +-
 drivers/staging/iio/gyro/Kconfig                   |  16 -
 drivers/staging/iio/gyro/Makefile                  |   6 -
 drivers/staging/iio/gyro/adis16060_core.c          | 234 -------
 include/dt-bindings/iio/adc/at91-sama5d2_adc.h     |  16 +
 include/uapi/linux/iio/types.h                     |   1 +
 tools/iio/iio_event_monitor.c                      |   2 +
 29 files changed, 1225 insertions(+), 472 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/resistive-adc-touch.txt
 create mode 100644 drivers/input/touchscreen/resistive-adc-touch.c
 delete mode 100644 drivers/staging/iio/gyro/Kconfig
 delete mode 100644 drivers/staging/iio/gyro/Makefile
 delete mode 100644 drivers/staging/iio/gyro/adis16060_core.c
 create mode 100644 include/dt-bindings/iio/adc/at91-sama5d2_adc.h
