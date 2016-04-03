Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:51545 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752795AbcDCV1J (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 3 Apr 2016 17:27:09 -0400
To: Greg KH <gregkh@linuxfoundation.org>
Subject: [PULL] First round of new device support, features and cleanups for
 IIO in the 4.7 cycle.
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <57018AAA.8070800@kernel.org>
Date: Sun, 3 Apr 2016 22:27:06 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following changes since commit 9bad1d0a5a0313b69597269474fd15849414cfae:

  staging: wilc1000: use switch statement instead of multiple if statement (2016-03-03 17:58:46 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-4.7a

for you to fetch changes up to 486294f184c05cff116160bb731cbb679f047621:

  iio: accel: bmc150: use common definition for regmap conf (2016-04-03 11:24:52 +0100)

----------------------------------------------------------------
First round of IIO new device support, features and cleanups for the 4.7 cycle.

New core support
* UV light modifier (for intensity)
* UV light index channel type.

New device support
* hp206c barometer and altimeter
  - new driver.
* mcp4131 potentiometer
  - new driver supporting lots of parts from Microchip.
* mma8452
  - FXLS8471Q support
- NXP LPC18XX SOC ADC
  - new driver.
- NXP LPC18XX SOC DAC
  - new driver.
- rockchip_saradc
  - support rk3399
* st accel
  - h3lis331dl support

Staging driver removals
* adis16204
  - obsolete part making it hard to get parts to test the driver in order
    to clean it up.
* adis16220
  - obsolete part making it hard to get the parts test the driver in order
    to clean it up.

Features
* core
  - convenience functions to claim / release direct access to the device.
    Makes more consistent handling of this corner easier. Used in ad7192 driver.
* ak8975
  - power regulator support.
* at91-sama5d2
  - differential channel support.
* mma8452
  - runtime pm support
  - drop device specific autosleep and use the runtime pm one instead.
* ms5611
  - DT bindings
  - oversampling ratio support

Cleanups and minor fixes
* MAINTAINERS
  - Peter got married - hence name change!

* Documentation
  - Fix a typo in in_proximity_raw description.
  - Add some missing docs for iio_buffer_access_funcs.

* Tools
  - update iio_event_monitor names to match new stuff.
  - make generic_buffer look for triggers ending in -trigger as we let these in
  for a number of drivers a long time back and now it is a fairly common
  option.

Drivers
* staging wide
  - convert bare unsigned usage to unsigned int to comply with coding style.
* non staging wide:
  - since boiler plate gpio handling of interrupts has been moved into the
   ACPI core we don't need to include gpio/consumer.h in a load of drivers so
   drop it.
* ad7606
  - fix an endian casting sparse warning.
* ak8975
  - fix a possible unitialized warning from gcc.
  - drop and unused field left over from earlier cleanups
  - fix a missing regulator_disable on exit.
* at91-sama5d2
  - typo and indentation
  - missing IOMEM dependency.
  - cleanup mode register usage by avoidling erasing whole thing when changing
  the sampling frequency.
* bmc150
  - use the core demux and available_scan_masks to simplify buffer handling
  - optimize the transfers in the trigger handler now we have a magic function
  to emulate bulk reads (under circumstances met here).  This matters with some
  rather dumb i2c adapters in particular.
  - use a single regmap_conf for all bus types as they were all the same.
* bmg160
  - use the core demux and available_scan_masks to simplify the buffer handling
  - optimize the transfers in the trigger handler now we have a magic funciton
  to emulate bulk rads (under circumstances met here).
  - drop gpio interrupt probing from the driver (ACPI) as now handled by the
  ACPI core.
* ina2xx-adc
  - update the CALIB register when RShunt changes.
  - fix scale for VShunt - in reality this error canceled out when used.
* isl29028
  - use regmap to retrieve the struct device instead of carrying a second
  copy of it around.
* kxcjk-1013
  - use core demux
  - optimize i2c transfers in the trigger handler.
* mcp4531
  - refactor to use a pointer to access model parameters instead of indexing
    into the array each time.
* mma8452
  - style fixes
  - avoid swtiching to active whenever the config changes
  - add missin i2c_device_id for mma8451
* mpu6050
  - fix possible NULL dereference.
  - fix the name / chip_id used when ACPI used (otherwise reports as NULL).
* ms5611
  - fix a missing regulator_disable that left the regulator on during removal.
* mxc4005
  - drop gpio interrupt handling for ACPI case from driver as the core now
  handles this case.
* st-sensors
  - note that there are only ever a maximum of 3 axis on current st-sensors
  so just allocate a fixed sized buffer big enough for that.
* tpl0102
  - change the i2c_check_functionality condition to bring it inline with other
    IIO users as EOPNOTSUPP.
* tsl2563
  - replace deprecated flush_scheduled_work

----------------------------------------------------------------
Adriana Reus (2):
      iio: accel: kxcjk-1013: use available_scan_masks
      iio: accel: kxcjk-1013: optimize i2c transfers in trigger handler

Alison Schofield (4):
      iio: core: implement iio_device_{claim|release}_direct_mode()
      staging: iio: ad7192: use iio_device_{claim|release}_direct_mode()
      staging: iio: isl29028: use regmap to retrieve struct device
      staging: iio: convert bare unsigned usage to unsigned int

Amitoj Kaur Chawla (1):
      iio: light: tsl2563: Remove flush_scheduled_work

Crestez Dan Leonard (1):
      hp206c: Initial support for reading sensor values

Daniel Baluta (1):
      iio: imu: mpu6050: Fix name/chip_id when using ACPI

David Wu (1):
      iio: adc: rockchip_saradc: add saradc support for rk3399

Gregor Boirie (6):
      iio:pressure:ms5611: oversampling rate support
      iio:magnetometer:ak8975: fix uninitialized chipset
      iio:magnetometer:ak8975: remove unused field
      iio:magnetometer:ak8975: power regulator support
      iio:pressure:ms5611: fix missing regulator_disable
      iio:magnetometer:ak8975: fix missing regulator_disable

Grégor Boirie (1):
      iio:pressure:ms5611: complete DT support

Irina Tirdea (7):
      iio: accel: bmc150: use available_scan_masks
      iio: accel: bmc150: optimize transfers in trigger handler
      iio: gyro: bmg160: use available_scan_masks
      iio: accel: bmg160: optimize transfers in trigger handler
      iio: remove unused gpio consumer.h include
      iio: remove gpio interrupt probing from drivers that use a single interrupt
      iio: accel: bmc150: use common definition for regmap conf

Joachim Eastwood (4):
      iio: adc: add NXP LPC18xx ADC driver
      dt: document NXP LPC1850 ADC driver bindings
      iio: dac: add NXP LPC18xx DAC driver
      dt: document NXP LPC1850 DAC driver bindings

Krzysztof Kozlowski (1):
      iio: adc: Fix build error of missing devm_ioremap_resource on UM

Ksenija Stanojevic (1):
      Staging: iio: ad7606: Fix sparse endian warning

Lars-Peter Clausen (2):
      staging:iio:adis16204: Remove adis16204 driver
      staging:iio:adis16220: Remove adis16220 driver

Linus Walleij (2):
      iio: st_sensors: simplify buffer address handling
      iio: tools: make generic_buffer look for "-trigger"

Ludovic Desroches (4):
      iio:adc:at91-sama5d2: fix typo
      iio:adc:at91-sama5d2: fix identation
      iio:adc:at91-sama5d2: cleanup mode register use
      iio:adc:at91-sama5d2: add support for differential conversions

Luis de Bethencourt (1):
      iio: buffer: add missing descriptions in iio_buffer_access_funcs

Marc Titinger (2):
      iio: ina2xx-adc: update the CALIB. register when RShunt changes
      iio: ina2xx-adc: fix scale for VShunt

Martin Kepplinger (6):
      iio: mma8452: coding style fixes
      iio: mma8452: avoid switching to active because of config change
      iio: mma8452: add support for runtime power management
      iio: mma8452: add support for FXLS8471Q
      iio: mma8452: add i2c_device_id for mma8451
      iio: mma8452: use runtime pm instead of device specific autosleep

Matt Ranostay (2):
      iio: potentiometer: tpl0102: change i2c functionality return code
      iio: imu: mpu6050: fix possible NULL dereferences

Peter Meerwald (1):
      iio: ABI: Fix typo in in_proximity_raw description

Peter Meerwald-Stadler (4):
      MAINTAINERS: update pmeerw's name
      tools: iio: Update iio_event_monitor names
      iio: Add modifier for UV light
      iio: Add channel for UV index

Slawomir Stepien (2):
      iio: potentiometer: mcp4531: use pointer to access model parameters
      iio: potentiometer: add driver for Microchip MCP413X/414X/415X/416X/423X/424X/425X/426X

Tiberiu Breana (1):
      iio: accel: Add support for the h3lis331dl accelerometer

 Documentation/ABI/testing/sysfs-bus-iio            |  15 +-
 .../devicetree/bindings/iio/accel/mma8452.txt      |   3 +-
 .../devicetree/bindings/iio/adc/lpc1850-adc.txt    |  21 +
 .../bindings/iio/adc/rockchip-saradc.txt           |   6 +-
 .../devicetree/bindings/iio/dac/lpc1850-dac.txt    |  20 +
 .../bindings/iio/magnetometer/ak8975.txt           |   2 +
 .../bindings/iio/potentiometer/mcp4131.txt         |  84 ++++
 .../devicetree/bindings/iio/pressure/ms5611.txt    |  19 +
 .../devicetree/bindings/iio/st-sensors.txt         |   1 +
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 MAINTAINERS                                        |   2 +-
 drivers/iio/accel/Kconfig                          |   5 +-
 drivers/iio/accel/bmc150-accel-core.c              |  29 +-
 drivers/iio/accel/bmc150-accel-i2c.c               |   7 +-
 drivers/iio/accel/bmc150-accel-spi.c               |   8 +-
 drivers/iio/accel/bmc150-accel.h                   |   1 +
 drivers/iio/accel/kxcjk-1013.c                     |  25 +-
 drivers/iio/accel/mma8452.c                        | 188 +++++++-
 drivers/iio/accel/mma9553.c                        |   1 -
 drivers/iio/accel/mxc4005.c                        |  29 --
 drivers/iio/accel/st_accel.h                       |   1 +
 drivers/iio/accel/st_accel_core.c                  |  92 ++++
 drivers/iio/accel/st_accel_i2c.c                   |   4 +
 drivers/iio/accel/stk8312.c                        |   1 -
 drivers/iio/accel/stk8ba50.c                       |   1 -
 drivers/iio/adc/Kconfig                            |  11 +
 drivers/iio/adc/Makefile                           |   1 +
 drivers/iio/adc/at91-sama5d2_adc.c                 | 102 +++--
 drivers/iio/adc/ina2xx-adc.c                       |  43 +-
 drivers/iio/adc/lpc18xx_adc.c                      | 231 ++++++++++
 drivers/iio/adc/rockchip_saradc.c                  |  19 +
 drivers/iio/common/st_sensors/st_sensors_buffer.c  |  28 +-
 drivers/iio/dac/Kconfig                            |  10 +
 drivers/iio/dac/Makefile                           |   1 +
 drivers/iio/dac/lpc18xx_dac.c                      | 210 +++++++++
 drivers/iio/gyro/bmg160_core.c                     |  52 +--
 drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c          |  30 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c          |   3 +-
 drivers/iio/imu/kmx61.c                            |   1 -
 drivers/iio/industrialio-core.c                    |  41 ++
 drivers/iio/light/stk3310.c                        |   1 -
 drivers/iio/light/tsl2563.c                        |   3 +-
 drivers/iio/magnetometer/ak8975.c                  |  70 ++-
 drivers/iio/magnetometer/bmc150_magn.c             |   1 -
 drivers/iio/potentiometer/Kconfig                  |  18 +
 drivers/iio/potentiometer/Makefile                 |   1 +
 drivers/iio/potentiometer/mcp4131.c                | 494 +++++++++++++++++++++
 drivers/iio/potentiometer/mcp4531.c                |  13 +-
 drivers/iio/potentiometer/tpl0102.c                |   2 +-
 drivers/iio/pressure/Kconfig                       |  10 +
 drivers/iio/pressure/Makefile                      |   1 +
 drivers/iio/pressure/hp206c.c                      | 426 ++++++++++++++++++
 drivers/iio/pressure/ms5611.h                      |  23 +-
 drivers/iio/pressure/ms5611_core.c                 | 146 +++++-
 drivers/iio/pressure/ms5611_i2c.c                  |  25 +-
 drivers/iio/pressure/ms5611_spi.c                  |  32 +-
 drivers/staging/iio/accel/Kconfig                  |  23 -
 drivers/staging/iio/accel/Makefile                 |   6 -
 drivers/staging/iio/accel/adis16204.h              |  68 ---
 drivers/staging/iio/accel/adis16204_core.c         | 253 -----------
 drivers/staging/iio/accel/adis16220.h              | 140 ------
 drivers/staging/iio/accel/adis16220_core.c         | 494 ---------------------
 drivers/staging/iio/adc/ad7192.c                   |  30 +-
 drivers/staging/iio/adc/ad7280a.c                  |  40 +-
 drivers/staging/iio/adc/ad7280a.h                  |   8 +-
 drivers/staging/iio/adc/ad7606.h                   |  28 +-
 drivers/staging/iio/adc/ad7606_core.c              |   6 +-
 drivers/staging/iio/adc/ad7606_spi.c               |   5 +-
 drivers/staging/iio/adc/ad7780.c                   |   2 +-
 drivers/staging/iio/impedance-analyzer/ad5933.c    |  14 +-
 drivers/staging/iio/light/isl29028.c               |  55 +--
 drivers/staging/iio/meter/ade7758_ring.c           |   4 +-
 drivers/staging/iio/resolver/ad2s1210.h            |   8 +-
 drivers/staging/iio/trigger/iio-trig-bfin-timer.c  |  12 +-
 include/linux/iio/buffer.h                         |   2 +
 include/linux/iio/iio.h                            |   2 +
 include/uapi/linux/iio/types.h                     |   2 +
 tools/iio/generic_buffer.c                         |  14 +-
 tools/iio/iio_event_monitor.c                      |  18 +
 79 files changed, 2497 insertions(+), 1352 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/lpc1850-adc.txt
 create mode 100644 Documentation/devicetree/bindings/iio/dac/lpc1850-dac.txt
 create mode 100644 Documentation/devicetree/bindings/iio/potentiometer/mcp4131.txt
 create mode 100644 Documentation/devicetree/bindings/iio/pressure/ms5611.txt
 create mode 100644 drivers/iio/adc/lpc18xx_adc.c
 create mode 100644 drivers/iio/dac/lpc18xx_dac.c
 create mode 100644 drivers/iio/potentiometer/mcp4131.c
 create mode 100644 drivers/iio/pressure/hp206c.c
 delete mode 100644 drivers/staging/iio/accel/adis16204.h
 delete mode 100644 drivers/staging/iio/accel/adis16204_core.c
 delete mode 100644 drivers/staging/iio/accel/adis16220.h
 delete mode 100644 drivers/staging/iio/accel/adis16220_core.c
