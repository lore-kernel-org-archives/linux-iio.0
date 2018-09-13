Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:36480 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726824AbeINBGJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 13 Sep 2018 21:06:09 -0400
Date: Thu, 13 Sep 2018 20:55:10 +0100
From: jic23@kernel.org
To: gregkh@linuxfoundation.org, linux-iio@vger.kernel.org
Subject: [PULL] First set of IIO new device support, features and cleanups
 for the 4.20 cycle.
Message-ID: <20180913205302.2a299be1@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following changes since commit 156c3df8d4db4e693c062978186f44079413d74d:

  staging: erofs: disable compiling temporarile (2018-08-02 12:15:44 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-4.20a

for you to fetch changes up to daae7861a696b66acb3547c1cb9247cb3abaf0b3:

  iio: light: bh1750: simplify setting PM ops (2018-09-08 16:01:40 +0100)

----------------------------------------------------------------
1st round of IIO new device support, features and cleanups in the 4.20 cycle.

There is a merge commit in here to pull in regmap support for repeatedly
reading the same register (to read out FIFOs).  Used by the adxl372 driver.
This will find uses elsewhere once we tidy up various drivers that are
effectively doing this and relying on not enabling regcache.

New device support
* Analog devices ADXL372 accelerometer
  - new driver for this accelerometer including fifo and and interrupt support.
    Follow up patches enforce trigger validation, add sampling frequency
    control and filter bandwidth control.  A later series added i2c support
    to the existing SPI support.
* ST lsm6dsx
  - rework and add support fo the LSM6DSO 6 axis mems sensor.
* Linear LTC 1660 DAC
  - new driver supporting the LTC 1660 and LTC 1665 SPI DACs.
* Microchip mcp3911 ADC.
  - new driver for this integrated analog front end and ADC.
* Qualcomm SPMI PMIC5 adc driver
  - using the spmi framework, new driver and bindings for this ADC.
    Follow up patch adds some missing channels.

Features
* ad5758
  - support hard reset using a gpio (if provided).
* mpu6050
  - Regulator support
* qcom-spmi-adc5
  - Sanity check the channel numbers provided by DT to make sure the
    driver actually knows about them.
* sc27xx
  - give raw data for channel 20 as it's used on all known boards for
    the headset which needs a custom converstion function.  If it turns
    out someone builds a board where this isn't true we will deal with it
    when it happens.
  - add ADC scale calibration.
* tsl2772
  - support device tree binding to set the proximity led settings.
  - regulator supprot.
  - binding for apds9930 - trivial addition as register compatible with tsl2772.

Cleanups / Minor fixes

* adxl345
  - supress a static checker warning but explicitly checking if the id
    object is null.
* bh1750
  - avoid CONFIG_PM_SLEEP checks.
  - SPDX.
* bme680
  - spelling mistake
  - use clamp rather than open coding.
  - white space and other similar fixes.
  - rename MSK to MASK for clarifty and use GENMASK to specify them.
  - use the FIELD_GET macro rather than a very odd accessor of dividing by
    16 to get the shift.
  - rework to share handing for oversampling of the various channels in a
    unified way.
  - check explicitly for val2 in write_raw function to ensure it is 0.
  - drop some field defines that don't add anything.
* dpot-adc
  - SPDX
* envelope detector
  - SPDX
* isl29501
  - fix an ancient compiler warning mostly because it results in much
    nicer code.
* max30102
  - mark switch fall throughs.
* max44000
  - drop an unused variable.
* max512
  - avoid CONFIG_PM_SLEEP checks.
* max5481
  - use of_device_get_match_data rather than open coding it.
* max5821
  - avoid CONFIG_PM_SLEEP checks.
* max9611
  - explicity cast an enum to an integer to make it totally clear that
    this is intended.
* mcp4018
  - fix an inconsistent MODULE_LICENSE.
  - use of_device_get_match_data rather than open coding it.
* mcp4531
  - use of_device_get_match_data rather than open coding it.
  - SPDX
* mcp4725
  - avoid CONFIG_PM_SLEEP checks.
* mcp4922
  - Fix error handling and prevent writing a negative to when setting the
    output voltage.
* ms5611
  - drop deprecated compatible strings without manufacturer from being
    explicitly listed.  They are handled anyway.
  - SPDX
* multiplexer
  - SPDX
* qcom-vadc
  - fix inconsistent documentation for reg.
* ti-dac5571
  - provide and of_match_table.

* treewide
  - update Michael Hennerich's email address.
  - Use %pOFn rather than device_node.name.
* documentation.
  - tidy up a wrong kernel version for the introduction of the
    position_relative ABI.

----------------------------------------------------------------
Alexandru Ardelean (1):
      iio: adxl345: move null check for i2c id at start of probe

Baolin Wang (2):
      iio: adc: sc27xx: Add raw data support
      iio: adc: sc27xx: Add ADC scale calibration

Brian Masney (6):
      iio: imu: mpu6050: add support for regulator framework
      dt-bindings: iio: tsl2772: add new bindings
      iio: tsl2772: add support for reading proximity led settings from device tree
      dt-bindings: iio: tsl2772: add binding for avago,apds9930
      iio: tsl2772: add support for avago,apds9930
      iio: tsl2772: add support for regulator framework

Colin Ian King (2):
      iio: chemical: fix spelling mistake "failted" -> "failed"
      iio: max44000: remove unused variable max44000_alstim_shift

Crestez Dan Leonard (1):
      regmap: Add regmap_noinc_read API

David Frey (8):
      iio: chemical: bme680: use clamp macro
      iio: chemical: bme680: cleanup bme680_read_calib formatting
      iio: chemical: bme680: indent #defines consistently
      iio: chemical: bme680: change MSK->MASK in #defines
      iio: chemical: bme680: use GENMASK macro
      iio: chemical: bme680: use FIELD_GET macro
      iio: chemical: bme680: simplify oversampling handling
      iio: chemical: bme680: Remove field value defines

Eugen Hristev (1):
      iio: fix position relative kernel version

Geert Uytterhoeven (1):
      iio: light: isl29501: Simplify code to kill compiler warning

Gustavo A. R. Silva (1):
      iio: health: max30102: Mark expected switch fall-throughs

Himanshu Jha (1):
      iio: chemical: bme680: Add check for val2 in the write_raw function

Jonathan Cameron (1):
      Merge tag 'regmap-noinc-read' into togreg

Julia Lawall (1):
      iio: potentiometer: merge calls to of_match_device and of_device_get_match_data

Lorenzo Bianconi (5):
      iio: imu: st_lsm6dsx: add read_fifo callback to fifo_ops
      iio: imu: st_lsm6dsx: make st_lsm6dsx_check_odr() non-static
      iio: imu: st_lsm6dsx: add addr/max_word_len to st_lsm6dsx_read_block()
      iio: imu: st_lsm6dsx: add support to LSM6DSO
      dt-bindings: iio: imu: st_lsm6dsx: add LSM6DSO device bindings

Marcus Folkesson (11):
      iio: dac: max517: avoid using CONFIG_PM_SLEEP
      iio: dac: max5821: avoid using CONFIG_PM_SLEEP
      iio: dac: mcp4725: avoid using CONFIG_PM_SLEEP
      iio: adc: add support for mcp3911
      dt-bindings: iio: adc: add bindings for mcp3911
      MAINTAINERS: Add entry for mcp3911 ADC driver
      iio: dac: add support for ltc1660
      dt-bindings: iio: dac: add bindings for ltc1660
      MAINTAINERS: add entry for ltc1660 DAC driver
      iio: dac: mcp4922: fix error handling in mcp4922_write_raw
      iio: dac: ti-dac5571: provide of_match_table to driver

Matthias Kaehlcke (3):
      iio: adc: qcom-spmi-adc5: Add ADC5_AMUX_THM[24]_100K_PU to rev2 channel list
      iio: adc: qcom-spmi-adc5: Verify channel numbers from DT
      dt-bindings: iio: vadc: Fix documentation of 'reg'

Michael Hennerich (1):
      drivers: iio: Update MODULE AUTHOR email address

Peter Rosin (5):
      iio: potentiometer: mcp4018: use the correct MODULE_LICENSE
      iio: potentiometer: mcp4531: switch to SPDX license identifier
      iio: envelope-detector: switch to SPDX license identifier
      iio: dpot-dac: switch to SPDX license identifier
      iio: multiplexer: switch to SPDX license identifier

Rob Herring (1):
      iio: Convert to using %pOFn instead of device_node.name

Siddartha Mohanadoss (3):
      dt-bindings: iio: adc: Add DT binding document for PMIC5 ADC
      iio: adc: Add QCOM SPMI PMIC5 ADC driver
      iio: adc: Update QCOM ADC license to SPDX format

Stefan Agner (1):
      iio: adc: max9611: explicitly cast gain_selectors

Stefan Popa (10):
      iio: adxl372: New driver for Analog Devices ADXL372 Accelerometer
      dt-bindings: iio: accel: Add docs for ADXL372
      iio:adxl372: Add FIFO and interrupts support
      iio: adxl372: Provide validate_trigger and validate_device callbacks
      iio:adxl372: Add sampling frequency support
      iio:adxl372: Add filter bandwidth support
      iio: dac: ad5758: Add support for hard reset
      iio: adxl372: Refactor the driver
      iio: adxl372: Add support for I2C communication
      dt-bindings: adxl372: Document the adxl372 I2C bindings

Tomasz Duszynski (4):
      iio: pressure: ms5611: remove deprecated compatible strings
      iio: light: bh1750: switch to SPDX identifier
      iio: pressure: ms5611: switch to SPDX identifier
      iio: light: bh1750: simplify setting PM ops

 Documentation/ABI/testing/sysfs-bus-iio            |   2 +-
 .../devicetree/bindings/iio/accel/adxl372.txt      |  33 +
 .../devicetree/bindings/iio/adc/mcp3911.txt        |  30 +
 .../devicetree/bindings/iio/adc/qcom,spmi-vadc.txt |  81 +-
 .../bindings/iio/adc/sprd,sc27xx-adc.txt           |   4 +
 .../devicetree/bindings/iio/dac/ad5758.txt         |   5 +
 .../devicetree/bindings/iio/dac/ltc1660.txt        |  21 +
 .../devicetree/bindings/iio/imu/inv_mpu6050.txt    |   1 +
 .../devicetree/bindings/iio/imu/st_lsm6dsx.txt     |   1 +
 .../devicetree/bindings/iio/light/tsl2772.txt      |  42 +
 .../devicetree/bindings/trivial-devices.txt        |  10 -
 MAINTAINERS                                        |  24 +
 drivers/base/regmap/internal.h                     |   3 +
 drivers/base/regmap/regmap.c                       |  79 +-
 drivers/iio/accel/Kconfig                          |  27 +
 drivers/iio/accel/Makefile                         |   3 +
 drivers/iio/accel/adxl345_i2c.c                    |   5 +-
 drivers/iio/accel/adxl372.c                        | 975 +++++++++++++++++++++
 drivers/iio/accel/adxl372.h                        |  17 +
 drivers/iio/accel/adxl372_i2c.c                    |  61 ++
 drivers/iio/accel/adxl372_spi.c                    |  52 ++
 drivers/iio/adc/Kconfig                            |  30 +
 drivers/iio/adc/Makefile                           |   2 +
 drivers/iio/adc/ad7298.c                           |   2 +-
 drivers/iio/adc/ad7476.c                           |   2 +-
 drivers/iio/adc/ad7793.c                           |   2 +-
 drivers/iio/adc/ad7887.c                           |   2 +-
 drivers/iio/adc/ad7923.c                           |   2 +-
 drivers/iio/adc/ad799x.c                           |   2 +-
 drivers/iio/adc/envelope-detector.c                |   5 +-
 drivers/iio/adc/max9611.c                          |   2 +-
 drivers/iio/adc/mcp3911.c                          | 363 ++++++++
 drivers/iio/adc/qcom-pm8xxx-xoadc.c                |   4 +-
 drivers/iio/adc/qcom-spmi-adc5.c                   | 793 +++++++++++++++++
 drivers/iio/adc/qcom-vadc-common.c                 | 189 +++-
 drivers/iio/adc/qcom-vadc-common.h                 |  54 ++
 drivers/iio/adc/rcar-gyroadc.c                     |  12 +-
 drivers/iio/adc/sc27xx_adc.c                       | 154 +++-
 drivers/iio/amplifiers/ad8366.c                    |   2 +-
 drivers/iio/chemical/bme680.h                      |  19 +-
 drivers/iio/chemical/bme680_core.c                 | 154 ++--
 drivers/iio/dac/Kconfig                            |  10 +
 drivers/iio/dac/Makefile                           |   1 +
 drivers/iio/dac/ad5446.c                           |   2 +-
 drivers/iio/dac/ad5504.c                           |   2 +-
 drivers/iio/dac/ad5686.c                           |   2 +-
 drivers/iio/dac/ad5758.c                           |  26 +-
 drivers/iio/dac/ad5791.c                           |   2 +-
 drivers/iio/dac/dpot-dac.c                         |   5 +-
 drivers/iio/dac/ltc1660.c                          | 250 ++++++
 drivers/iio/dac/max517.c                           |  11 +-
 drivers/iio/dac/max5821.c                          |  11 +-
 drivers/iio/dac/mcp4725.c                          |  12 +-
 drivers/iio/dac/mcp4922.c                          |  11 +-
 drivers/iio/dac/ti-dac5571.c                       |   1 +
 drivers/iio/frequency/ad9523.c                     |   2 +-
 drivers/iio/frequency/adf4350.c                    |   2 +-
 drivers/iio/health/max30102.c                      |   6 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c         |  62 ++
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h          |   2 +
 drivers/iio/imu/st_lsm6dsx/Kconfig                 |   2 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h            |  18 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c     | 166 +++-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c       |  51 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c        |   5 +
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c        |   5 +
 drivers/iio/light/bh1750.c                         |  14 +-
 drivers/iio/light/max44000.c                       |   1 -
 drivers/iio/light/tsl2772.c                        | 194 +++-
 drivers/iio/multiplexer/iio-mux.c                  |   5 +-
 drivers/iio/potentiometer/max5481.c                |   7 +-
 drivers/iio/potentiometer/mcp4018.c                |   9 +-
 drivers/iio/potentiometer/mcp4531.c                |  14 +-
 drivers/iio/pressure/ms5611.h                      |   5 +-
 drivers/iio/pressure/ms5611_core.c                 |   5 +-
 drivers/iio/pressure/ms5611_i2c.c                  |   7 +-
 drivers/iio/pressure/ms5611_spi.c                  |   7 +-
 drivers/iio/proximity/isl29501.c                   |  12 +-
 drivers/iio/trigger/iio-trig-sysfs.c               |   2 +-
 drivers/staging/iio/adc/ad7192.c                   |   2 +-
 drivers/staging/iio/adc/ad7280a.c                  |   2 +-
 drivers/staging/iio/adc/ad7606.c                   |   2 +-
 drivers/staging/iio/adc/ad7606_par.c               |   2 +-
 drivers/staging/iio/adc/ad7606_spi.c               |   2 +-
 drivers/staging/iio/adc/ad7780.c                   |   2 +-
 drivers/staging/iio/cdc/ad7746.c                   |   2 +-
 drivers/staging/iio/frequency/ad9832.c             |   2 +-
 drivers/staging/iio/frequency/ad9834.c             |   2 +-
 drivers/staging/iio/impedance-analyzer/ad5933.c    |   2 +-
 include/dt-bindings/iio/qcom,spmi-vadc.h           | 125 ++-
 include/linux/regmap.h                             |  19 +
 91 files changed, 4027 insertions(+), 357 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/accel/adxl372.txt
 create mode 100644 Documentation/devicetree/bindings/iio/adc/mcp3911.txt
 create mode 100644 Documentation/devicetree/bindings/iio/dac/ltc1660.txt
 create mode 100644 Documentation/devicetree/bindings/iio/light/tsl2772.txt
 create mode 100644 drivers/iio/accel/adxl372.c
 create mode 100644 drivers/iio/accel/adxl372.h
 create mode 100644 drivers/iio/accel/adxl372_i2c.c
 create mode 100644 drivers/iio/accel/adxl372_spi.c
 create mode 100644 drivers/iio/adc/mcp3911.c
 create mode 100644 drivers/iio/adc/qcom-spmi-adc5.c
 create mode 100644 drivers/iio/dac/ltc1660.c
