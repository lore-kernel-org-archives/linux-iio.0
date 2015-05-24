Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:57467 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751132AbbEXQFO (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 24 May 2015 12:05:14 -0400
Message-ID: <5561F6B7.2000005@kernel.org>
Date: Sun, 24 May 2015 17:05:11 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Greg KH <gregkh@linuxfoundation.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: [PULL] IIO new drivers etc for the 4.2 cycle round 2
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following changes since commit 5ccca155675a5a2d491257a441306dd8547695c2:

  Merge tag 'iio-for-v4.2a' of git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into staging-next (2015-05-09 18:15:50 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-v4.2b

for you to fetch changes up to 884ca45613c47efe4b0b1238f6ee677d74fe3419:

  iio: accel: Add support for Sensortek STK8BA50 (2015-05-23 12:57:11 +0100)

----------------------------------------------------------------
Second set of new driver, functionality and cleanups for IIO in the 4.2 cycle.

Core functionality
* i and q modifiers from quadrature channels.
* IIO_CHAN_INFO_OVERSAMPLING_RATIO added.
* High pass filter attributes added to mirror the existing low pass filter
  ones.

Core cleanups
* Make IIO tools building more cross compiler friendly.
* Substantial rework of the function __iio_update_buffers to greatly simplify
  a hideously evolved function.

New drivers and support
* ACPI0008 ambient light sensor driver. This one has been around a long time to
  will be good to finally get it into mainline.
* Berlin SOC ADC support.
* BMC150 magnetometer.  The accelerometer in the same package has been supported
  for quite some time, so good to have this half as well.
* m62332 DAC driver
* MEMSIC MMC35420 magnetometer.
* ROHM BH1710 and similar ambient light sensors.
* Sensortek STK3310 light sensor.
* Sensortek STK8312 accelerometer.
* Sensortek STK8BA50 accelerometer.
* ti-adc128s052 gains support form the adc122s021 2 channel ADC.

Driver cleanups and functionality.
* Allow various drivers to compile with !GPIOLIB if COMPILE_TEST enabled.
* bmc150 - decouple trigger from buffer to allow other triggers to be used.
* bmg160 - decouple trigger from buffer to allow other triggers to be used.
  Fix a trivial unused field.
* Constify a load of platform_device_id structures.
* inv_mpu6050 - device tree bindings.
* hid-sensors - fix a memory leak during probe if certain errors occur.
* ltr501 - illuminance channel derived (in an non obvious fashion) from the
  intensity channels.
* ltr501 - fix a boundary check on the proximity threshold.
* mlx90614 - drop a pointless return.
* mma8452 - Debugfs register access and fix a bug that had no effect (by
  coincidence)
* ti_am335x_adc - add device tree bindings for sample-delay, open-delay and
  averaging.  The ideal settings for these tend to be board design specific.

----------------------------------------------------------------
Antoine Tenart (2):
      iio: adc: add support for Berlin
      Documentation: bindings: document the Berlin ADC driver

Daniel Baluta (3):
      iio: magnetometer: Add support for MEMSIC MMC35240 sensor
      iio: magnetometer: mmc35240: Add PM sleep support
      iio: magnetometer: Add ACPI support for MMC35240

Dmitry Eremin-Solenikov (1):
      iio: add m62332 DAC driver

Fabio Estevam (6):
      iio: accel: hid-sensor-accel-3d: Fix memory leak in probe()
      iio: gyro: hid-sensor-gyro-3d: Fix memory leak in probe()
      iio: light: hid-sensor-als.c: Fix memory leak in probe()
      iio: orientation: hid-sensor-incl-3d: Fix memory leak in probe()
      iio: orientation: hid-sensor-rotation: Fix memory leak in probe()
      iio: pressure: hid-sensor-press: Fix memory leak in probe()

Gabriele Mazzotta (1):
      iio: acpi: Add support for ACPI0008 Ambient Light Sensor

Geert Uytterhoeven (2):
      iio: Allow compile test of GPIO consumers if !GPIOLIB
      Staging: iio: Allow compile test of GPIO consumers if !GPIOLIB

Irina Tirdea (4):
      iio: magn: Add support for BMC150 magnetometer
      iio: magn: bmc150_magn: Add devicetree binding documentation
      iio: core: Introduce IIO_CHAN_INFO_OVERSAMPLING_RATIO
      iio: magn: bmc150_magn: add oversampling ratio

Jonathan Cameron (1):
      iio:temp:mlx90614 trivial drop of unnecessary ret return from write_raw.

Krzysztof Kozlowski (9):
      iio: hid-sensor-accel-3d: Constify platform_device_id
      iio: adc: axp288: Constify platform_device_id
      iio: hid-sensor-gyro-3d: Constify platform_device_id
      iio: light: hid-sensor-als: Constify platform_device_id
      iio: light: hid-sensor-prox: Constify platform_device_id
      iio: hid-sensor-magn-3d: Constify platform_device_id
      iio: hid-sensor-incl-3d: Constify platform_device_id
      iio: hid-sensor-rotation: Constify platform_device_id
      iio: hid-sensor-press: Constify platform_device_id

Kuppuswamy Sathyanarayanan (2):
      iio: ltr501: Fix proximity threshold boundary check
      iio: ltr501: Add light channel support

Lars-Peter Clausen (7):
      iio: Replace printk in __iio_update_buffers with dev_dbg
      iio: __iio_update_buffers: Slightly refactor scan mask memory management
      iio: __iio_update_buffers: Perform request_update() only for new buffers
      iio: Add I/Q modifiers
      iio: __iio_update_buffers: Verify configuration before starting to apply it
      iio: __iio_update_buffers: Split enable and disable path into helper functions
      iio: __iio_update_buffers: Leave device in sane state on error

Linus Walleij (1):
      iio: make tools more cross-compilation friendly

Martin Fuzzey (3):
      iio: mma8452: Initialise before activating
      iio: mma8452: Add access to registers via DebugFS
      iio: core: add high pass filter attributes

Tiberiu Breana (4):
      iio: light: Add support for Sensortek STK3310
      iio: light: Add threshold interrupt support for STK3310
      iio: accel: Add support for Sensortek STK8312
      iio: accel: Add support for Sensortek STK8BA50

Tomasz Duszynski (1):
      iio: light: add support for ROHM BH1710/BH1715/BH1721/BH1750/BH1751 ambient light sensors

Urs Fässler (1):
      iio:adc128s052: add support for adc122s021

Varka Bhadram (1):
      imu: inv_mpu6050: adds device tree bindings

Vignesh R (1):
      iio: adc: ti_am335x_adc: make sample delay, open delay, averaging DT parameters

Vlad Dogaru (3):
      iio: gyro: bmg160: remove redundant field
      iio: gyro: bmg160: decouple buffer and triggers
      iio: accel: bmc150: decouple buffer and triggers

 Documentation/ABI/testing/sysfs-bus-iio            |   88 ++
 .../devicetree/bindings/iio/adc/berlin2_adc.txt    |   19 +
 .../devicetree/bindings/iio/adc/ti-adc128s052.txt  |    4 +-
 .../devicetree/bindings/iio/imu/inv_mpu6050.txt    |   17 +
 .../bindings/iio/magnetometer/bmc150_magn.txt      |   22 +
 .../bindings/input/touchscreen/ti-tsc-adc.txt      |   24 +
 drivers/iio/accel/Kconfig                          |   21 +
 drivers/iio/accel/Makefile                         |    3 +
 drivers/iio/accel/bmc150-accel.c                   |   55 +-
 drivers/iio/accel/hid-sensor-accel-3d.c            |   15 +-
 drivers/iio/accel/mma8452.c                        |   62 +-
 drivers/iio/accel/stk8312.c                        |  390 +++++++
 drivers/iio/accel/stk8ba50.c                       |  302 ++++++
 drivers/iio/adc/Kconfig                            |   11 +-
 drivers/iio/adc/Makefile                           |    1 +
 drivers/iio/adc/axp288_adc.c                       |    2 +-
 drivers/iio/adc/berlin2-adc.c                      |  378 +++++++
 drivers/iio/adc/ti-adc128s052.c                    |   30 +-
 drivers/iio/adc/ti_am335x_adc.c                    |   54 +-
 drivers/iio/dac/Kconfig                            |   10 +
 drivers/iio/dac/Makefile                           |    1 +
 drivers/iio/dac/m62332.c                           |  269 +++++
 drivers/iio/gyro/bmg160.c                          |   67 +-
 drivers/iio/gyro/hid-sensor-gyro-3d.c              |   15 +-
 drivers/iio/humidity/Kconfig                       |    2 +-
 drivers/iio/industrialio-buffer.c                  |  328 +++---
 drivers/iio/industrialio-core.c                    |    5 +
 drivers/iio/industrialio-event.c                   |    2 +
 drivers/iio/light/Kconfig                          |   34 +
 drivers/iio/light/Makefile                         |    3 +
 drivers/iio/light/acpi-als.c                       |  231 ++++
 drivers/iio/light/bh1750.c                         |  334 ++++++
 drivers/iio/light/hid-sensor-als.c                 |   14 +-
 drivers/iio/light/hid-sensor-prox.c                |    2 +-
 drivers/iio/light/ltr501.c                         |   53 +-
 drivers/iio/light/stk3310.c                        |  722 +++++++++++++
 drivers/iio/magnetometer/Kconfig                   |   29 +-
 drivers/iio/magnetometer/Makefile                  |    3 +
 drivers/iio/magnetometer/bmc150_magn.c             | 1109 ++++++++++++++++++++
 drivers/iio/magnetometer/hid-sensor-magn-3d.c      |    2 +-
 drivers/iio/magnetometer/mmc35240.c                |  512 +++++++++
 drivers/iio/orientation/hid-sensor-incl-3d.c       |   16 +-
 drivers/iio/orientation/hid-sensor-rotation.c      |   17 +-
 drivers/iio/pressure/hid-sensor-press.c            |   14 +-
 drivers/iio/temperature/mlx90614.c                 |    4 +-
 drivers/staging/iio/accel/Kconfig                  |    2 +-
 drivers/staging/iio/adc/Kconfig                    |    6 +-
 drivers/staging/iio/addac/Kconfig                  |    2 +-
 drivers/staging/iio/resolver/Kconfig               |    4 +-
 include/linux/iio/iio.h                            |    2 +
 include/linux/iio/types.h                          |    2 +
 include/uapi/linux/iio/types.h                     |    2 +
 tools/iio/Makefile                                 |    4 +-
 53 files changed, 5061 insertions(+), 259 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/berlin2_adc.txt
 create mode 100644 Documentation/devicetree/bindings/iio/imu/inv_mpu6050.txt
 create mode 100644 Documentation/devicetree/bindings/iio/magnetometer/bmc150_magn.txt
 create mode 100644 drivers/iio/accel/stk8312.c
 create mode 100644 drivers/iio/accel/stk8ba50.c
 create mode 100644 drivers/iio/adc/berlin2-adc.c
 create mode 100644 drivers/iio/dac/m62332.c
 create mode 100644 drivers/iio/light/acpi-als.c
 create mode 100644 drivers/iio/light/bh1750.c
 create mode 100644 drivers/iio/light/stk3310.c
 create mode 100644 drivers/iio/magnetometer/bmc150_magn.c
 create mode 100644 drivers/iio/magnetometer/mmc35240.c
