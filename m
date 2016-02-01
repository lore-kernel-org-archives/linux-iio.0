Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:38014 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752872AbcBAUj2 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 1 Feb 2016 15:39:28 -0500
To: Greg KH <gregkh@linuxfoundation.org>
Subject: [PULL] First set of new IIO drivers, features and cleanups for the
 4.6 cycle.
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56AFC27C.9060400@kernel.org>
Date: Mon, 1 Feb 2016 20:39:24 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following changes since commit 02c34ccc1d2d528d2de2897881b97933363432b5:

  Merge tag 'iio-for-4.5c' of git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into staging-next (2015-12-26 17:05:25 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-4.6a

for you to fetch changes up to ea4570d6c29994017e09196d1f8077fb5942b676:

  iio: light: opt3001: Add device tree binding documentation (2016-02-01 19:53:12 +0000)

----------------------------------------------------------------
First round of new IIO device support, features and cleanups for the 4.6 cycle.

Device Support
* ad5761
  - new driver
* at91_sama5d2 ADC.
  - new driver and MAINTAINERS entry.
  - minor cleanups followed.
* atlas pH-SM
  - new driver (this has possibly the prettiest data sheet I've ever seen)
* mcp3422
  - mcp3425 ADC added.
* mcp4725
  - mcp4726 DAC added.
* mma8452
  - mma8451q accelerometer added.
* mpl115
  - mpl115a1 added (a lot bigger than it seems as this is an SPI part whereas
    previous parts were i2c).
* si7005
  - Hoperf th02 (seems to be a repackaged part)
* si7020
  - Hoperf th06 (seems to be a repackaged part)

New features
* Core
  - IIO_PH type. Does what it says on the tin.
* max30100
  - LED current configuration support.
* mcp320x
  - more differential measurement combinations.
* mma8452
  - free fall deteciton
- opt3001
  - enable operation without a IRQ line.
  - device tree docs.  Somehow the original docs have disappeared down
    a rabbit hole, so here is a new set.
* st-sensors
  - Support active-low interrupts.

Cleanups and minor / not so minor reworks
* Documentation
  - drop some defunct ABI from the docs in staging.
* presure / Kconfig
  - white space cleanup.
* ad7150
  - BIT macro usage
  - Alignment fixes
* ad7192
  - false indent fixed.
* ak8975
  - constify the ak_def structures
* axp288
  - drop a redundant double const.
* dht11
  - substantial reliability improvements by being more tolerant
    of missing start bits.
  - simplify the decoding algorithm
* mma8452
  - whitespace cleanup
* mpl115
  - don't bother setting i2c_client_data as nothing uses it.
* mpu6050
  - drop unused function parameter.
* opt3001
  - extract integration time as constants.
  - trivial refactoring.

----------------------------------------------------------------
Adriana Reus (1):
      iio: inv_mpu6050: Remove unused parameter

Akinobu Mita (5):
      iio: adc: mcp3422: Add support for MCP3425
      iio: dac: mcp4725: Add basic support for MCP4726
      iio: adc: mcp320x: support more differential voltage measurement
      iio: pressure: mpl115: don't set unused i2c clientdata
      iio: pressure: mpl115: support MPL115A1

Alexander Koch (3):
      iio: light: opt3001: extract int. time constants
      iio: light: opt3001: trivial type refactoring
      iio: light: opt3001: enable operation w/o IRQ

Andreas Dannenberg (1):
      iio: light: opt3001: Add device tree binding documentation

Colin Ian King (2):
      iio: adc: axp288: remove redundant duplicate const on axp288_adc_channels
      Staging: iio: adc: fix indent on break statement

Cristina Moraru (2):
      iio: si7005: add support for Hoperf th02
      iio: si7020: add support for Hoperf th06

Harald Geyer (2):
      iio: dht11: Improve reliability - be more tolerant about missing start bits
      iio: dht11: Simplify decoding algorithm

Jonathan Cameron (1):
      iio:pressure:Kconfig white space cleanup.

Julia Lawall (1):
      iio: ak8975: constify ak_def structures

Linus Walleij (1):
      iio: st_sensors: support active-low interrupts

Ludovic Desroches (4):
      iio:adc:at91_adc8xx: introduce new atmel adc driver
      MAINTAINERS: add entry for Atmel SAMA5D2 ADC driver
      iio:adc:at91-sama5d2: fix vref_uv type
      iio:adc:at91-sama5d2: code cleanup

Martin Kepplinger (3):
      iio: mma8452: add freefall detection for Freescale's accelerometers
      iio: mma8452: whitespace cleanup
      iio: mma8452: add support for MMA8451Q

Matt Ranostay (4):
      iio: health: max30100: add config for LED current
      devicetree: add Atlas Scientific LLC vendor prefix
      iio: ph: add IIO_PH channel type
      iio: chemical: add Atlas pH-SM sensor support

Ricardo Ribalda Delgado (1):
      iio: add ad5761 DAC driver

Shraddha Barke (3):
      Staging: iio: cdc: ad7150: Prefer using the BIT macro
      Staging: iio: cdc: ad7150: Fix alignment should match open parenthesis
      Staging: iio: Documentation: Remove unused sysfs attributes

 CREDITS                                            |   1 +
 Documentation/ABI/testing/sysfs-bus-iio            |   9 +
 .../devicetree/bindings/iio/accel/mma8452.txt      |   4 +-
 .../bindings/iio/adc/at91-sama5d2_adc.txt          |  28 ++
 .../devicetree/bindings/iio/adc/mcp3422.txt        |   1 +
 .../bindings/iio/chemical/atlas,ph-sm.txt          |  22 +
 .../devicetree/bindings/iio/health/max30100.txt    |   8 +
 .../devicetree/bindings/iio/light/opt3001.txt      |  26 ++
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 MAINTAINERS                                        |   6 +
 drivers/iio/accel/Kconfig                          |   2 +-
 drivers/iio/accel/mma8452.c                        | 206 ++++++++-
 drivers/iio/accel/st_accel_core.c                  |  16 +
 drivers/iio/adc/Kconfig                            |  16 +-
 drivers/iio/adc/Makefile                           |   1 +
 drivers/iio/adc/at91-sama5d2_adc.c                 | 508 ++++++++++++++++++++
 drivers/iio/adc/axp288_adc.c                       |   2 +-
 drivers/iio/adc/mcp320x.c                          |  31 +-
 drivers/iio/adc/mcp3422.c                          |   7 +-
 drivers/iio/chemical/Kconfig                       |  13 +
 drivers/iio/chemical/Makefile                      |   1 +
 drivers/iio/chemical/atlas-ph-sensor.c             | 511 +++++++++++++++++++++
 drivers/iio/common/st_sensors/st_sensors_core.c    |   6 +-
 drivers/iio/common/st_sensors/st_sensors_core.h    |   8 +
 drivers/iio/common/st_sensors/st_sensors_trigger.c |  52 ++-
 drivers/iio/dac/Kconfig                            |  14 +-
 drivers/iio/dac/Makefile                           |   1 +
 drivers/iio/dac/ad5761.c                           | 430 +++++++++++++++++
 drivers/iio/dac/mcp4725.c                          |  87 +++-
 drivers/iio/gyro/st_gyro_core.c                    |  15 +
 drivers/iio/health/max30100.c                      |  81 +++-
 drivers/iio/humidity/Kconfig                       |   6 +-
 drivers/iio/humidity/dht11.c                       |  77 ++--
 drivers/iio/humidity/si7005.c                      |   1 +
 drivers/iio/humidity/si7020.c                      |   1 +
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c         |   5 +-
 drivers/iio/industrialio-core.c                    |   1 +
 drivers/iio/light/opt3001.c                        | 156 +++++--
 drivers/iio/magnetometer/ak8975.c                  |   4 +-
 drivers/iio/magnetometer/st_magn_core.c            |   4 +
 drivers/iio/pressure/Kconfig                       |  41 +-
 drivers/iio/pressure/Makefile                      |   2 +
 drivers/iio/pressure/mpl115.c                      |  66 ++-
 drivers/iio/pressure/mpl115.h                      |  24 +
 drivers/iio/pressure/mpl115_i2c.c                  |  67 +++
 drivers/iio/pressure/mpl115_spi.c                  | 106 +++++
 drivers/iio/pressure/st_pressure_core.c            |   8 +
 .../staging/iio/Documentation/sysfs-bus-iio-light  |  28 --
 drivers/staging/iio/adc/ad7192.c                   |   2 +-
 drivers/staging/iio/cdc/ad7150.c                   |  34 +-
 include/linux/iio/common/st_sensors.h              |   4 +
 include/linux/platform_data/ad5761.h               |  44 ++
 include/uapi/linux/iio/types.h                     |   1 +
 53 files changed, 2531 insertions(+), 265 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/at91-sama5d2_adc.txt
 create mode 100644 Documentation/devicetree/bindings/iio/chemical/atlas,ph-sm.txt
 create mode 100644 Documentation/devicetree/bindings/iio/light/opt3001.txt
 create mode 100644 drivers/iio/adc/at91-sama5d2_adc.c
 create mode 100644 drivers/iio/chemical/atlas-ph-sensor.c
 create mode 100644 drivers/iio/common/st_sensors/st_sensors_core.h
 create mode 100644 drivers/iio/dac/ad5761.c
 create mode 100644 drivers/iio/pressure/mpl115.h
 create mode 100644 drivers/iio/pressure/mpl115_i2c.c
 create mode 100644 drivers/iio/pressure/mpl115_spi.c
 create mode 100644 include/linux/platform_data/ad5761.h
