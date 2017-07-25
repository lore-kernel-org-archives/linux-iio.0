Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:33642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752421AbdGYUAb (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 25 Jul 2017 16:00:31 -0400
Date: Tue, 25 Jul 2017 21:00:27 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org
Subject: [PULL] First set of IIO new device support, features and cleanups
 for the 4.14 cycle.
Message-ID: <20170725210027.745c6520@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following changes since commit 9b326dfce12afb429915c63f5a3df4afa4bea957:

  staging: lustre: replace kmalloc with kmalloc_array (2017-06-29 16:38:53 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-4.14a

for you to fetch changes up to f3f0ae16f0ce2a11067b958c7cf2a48c32ea6d60:

  iio: humidity: hts221: move drdy enable logic in hts221_trig_set_state() (2017-07-25 20:03:04 +0100)

----------------------------------------------------------------
First round of IIO new device support, features and cleanups for the 4.14 cycle.

4 completely new drivers in this set and plenty of other stuff.

One ABI change due to a silly mistake a long time back. Hopefully no
one will notice.  It effects the numerical order of consumer device
channels which was the reverse of the obvious.  It's going the slow
way to allow us some margin to spot if we have broken userspace or
not (seems unlikely)

New Device Support
* ccs811
  - new driver for the Volatile Organic Compounds (VOC) sensor.
* dln2 adc
  - new driver for the ADC on this flexible usb board.
* EP93xx
  - new driver for this Cirrus logic SoC ADC.
* ltc2471
  - new ADC driver support the ltc2471 and ltc2473
* st_accel
  - add trivial table entries to support H3LIS331DL, LIS331DL, LIS3LV02DL.
* st_gyro
  - add L3GD20H support (again) having fixed the various things that were
    broken in the first try.  Includes devicetree binding.
* stm32 dac
  - add support for the DACs in the STM32F4 series

Features
* Documentation
  - add missing power attribute documentation to the ABI docs.
* at91-sama5d2
  - add hardware trigger and buffered capture support with bindings.
  - suspend and resume functionality.
* bmc150
  - support for the BOSC0200 ACPI device id seen on some tablets.
* hdc100x
  - devicetree bindings
  - document supported devices
  - match table and device ids.
* hts221
  - support active low interrupts (with bindings)
  - open drain mode with bindings.
* htu21
  - OF match table and bindings.
* lsm6dsx
  - open drain mode with bindings
* ltc2497
  - add support for board file based consumer mapping.
* ms5367
  - OF match table and bindings.
* mt7622
  - binding document and OF match table.
  - suspend and resume support.
* rpr0521
  - triggered buffer support.
* tsys01
  - OF match table and bindings.

Cleanups and minor fixes
* core
  - fix ordering of IIO channels to entry numbers when using
    iio_map_array_register rather than reversing them.
  - use the new %pOF format specifier rather than full name for the
    device tree nodes.
* ad7280a
  - fix potential issue with macro argument reuse.
* ad7766
  - drop a pointless NULL value check as it's done in the gpiod code.
* adis16400
  - unsigned -> unsigned int.
* at91 adc
  - make some init data static to reduce code size.
* at91-sama5d2 ADC
  - make some init data static to reduce code size.
* da311
  - make some init data static to reduce code size.
* hid-sensor-rotation
  - drop an unnecessary static.
* hts221
  - refactor the write_with_mask code.
  - move the BDU configuration to probe time as there is no reason for it
    to change.
  - avoid overwriting reserved data during power-down.  This is a fix, but
    the infrastructure need was too invasive to send it to mainline except
    in a merge window.  It's not a regression as it was always wrong.
  - avoid reconfigure the sampling frequency multiple times by just
    doing it in the write_raw function directly.
  - refactor the power_on/off calls into a set_enable.
  - move the dry-enable logic into trig_set_state as that is the only
    place it was used.
* ina219
  - fix polling of ina226 conversion ready flag.
* imx7d
  - add vendor name in kconfig for consistency with similar parts.
* mcp3422
  - Change initial channel to 0 as it feels more logical.
  - Check for some errors in probe.
* meson-saradc
  - add a check of of_match_device return value.
* mpu3050
  - allow open drain for any interrupt type.
* rockchip adc
  - add check on of_match_device return value.
* sca3000
  - drop a trailing whitespace.
* stm32 adc
  - make array stm32h7_adc_ckmodes_spec static.
* stm32 dac
  - fix an error message.
* stm32 timers
  - fix clock name in docs to match reality after changes.
* st_accel
  - explicit OF table (spi).
  - add missing entries to OF table (i2c).
  - rename of_device_id table to drop the part name.
  - adding missing lis3l02dq entry to bindings.
  - rename H3LIS331DL_DRIVER_NAME to line up with similar entries in driver.
* st_gyro
  - explicit OF table (spi).
* st_magn
  - explicit OF table (spi).
  - enable multiread for lis3mdl.
* st_pressure
  - explicit OF table (spi).
* st_sensors common.
  - move st_sensors_of_i2c_probe and rename to make it available for spi
  drivers.
* tsc3472
  - don't write an extra byte when writing the ATIME register.
  - add a link to the datasheet.
* tsl2x7x - continued staging cleanups
  - add of_match_table.
  - drop redundant power_state sysfs attribute.
  - drop wrapper tsl2x7x_i2c_read.
  - clean up i2c calls made in tsl2x7x_als_calibrate.
  - refactor the read and write _event_value callbacks to handle additional
    elements.
  - use usleep_range instead of mdelay.
  - check return value from tsl2x7x_invoke_change.
* zpa2326
  - add some newline to the end of logging macros.

----------------------------------------------------------------
Akinobu Mita (2):
      iio: light: tcs3472: fix ATIME register write
      iio: light: tcs3472: add link to datasheet

Alexander Sverdlin (1):
      iio: adc: New driver for Cirrus Logic EP93xx ADC

Angelo Compagnucci (2):
      iio: adc: mcp3422: Changing initial channel
      iio: adc: mcp3422: Checking for error on probe

Brian Masney (7):
      staging: iio: tsl2x7x: add of_match table for device tree support
      staging: iio: tsl2x7x: remove redundant power_state sysfs attribute
      staging: iio: tsl2x7x: remove tsl2x7x_i2c_read()
      staging: iio: tsl2x7x: cleaned up i2c calls in tsl2x7x_als_calibrate()
      staging: iio: tsl2x7x: refactor {read,write}_event_value to allow handling multiple iio_event_infos
      staging: iio: tsl2x7x: use usleep_range() instead of mdelay()
      staging: iio: tsl2x7x: check return value from tsl2x7x_invoke_change()

Colin Ian King (4):
      iio: adc: stm32: make array stm32h7_adc_ckmodes_spec static
      iio: accel: make array init_data static to reduce code size
      iio:adc:at91-sama5d2: make array startup_lookup static to reduce code size
      iio: adc: at91: make array startup_lookup static

Eugen Hristev (3):
      Documentation: dt: iio: at91-sama5d2_adc: add hw trigger edge binding
      iio: adc: at91-sama5d2_adc: add hw trigger and buffer support
      iio: adc: at91-sama5d2_adc: add support for suspend/resume functionality

Fabio Estevam (2):
      iio: adc: Kconfig: Append vendor name for IMX7D_ADC
      iio: adc: ad7766: Remove unneeded gpiod NULL check

Fabrice Gasnier (4):
      dt-bindings: iio: update STM32 timers clock names
      dt-bindings: iio: stm32-dac: add support for STM32F4
      iio: dac: stm32: fix error message
      iio: dac: stm32: add support for stm32f4

Gaurav Gupta (2):
      iio:adc:ltc2497: Add support for board file based iio consumer mapping.
      iio: core: Fix mapping of iio channels to entry numbers

Gustavo A. R. Silva (2):
      iio: adc: meson-saradc: add NULL check on of_match_device() return value
      iio: adc: rockchip_saradc: add NULL check on of_match_device() return value

Hans de Goede (1):
      iio: accel: bmc150: Add support for BOSC0200 ACPI device id

Jack Andersen (1):
      iio: adc: Add support for DLN2 ADC

Jaya Durga (1):
      Staging: iio: adc: ad7280a.c: Fixed Macro argument reuse

Joe Perches (1):
      iio: pressure: zpa2326: Add newlines to logging macros

Julia Lawall (1):
      iio: orientation: hid-sensor-rotation: Drop unnecessary static

Linus Walleij (1):
      iio: gyro: mpu3050: Allow open drain with anything

Lorenzo Bianconi (25):
      iio: gyro: st_gyro: fix L3GD20H support
      dt-bindings: iio: gyro: add L3GD20H sensor device binding
      iio: magnetometer: st_magn_core: enable multiread by default for LIS3MDL
      iio: common: st_sensors: move st_sensors_of_i2c_probe() in common code
      iio: accel: st_accel_spi: rename of_device_id table in st_accel_of_match
      iio: imu: st_lsm6dsx: support open drain mode
      dt-bindings: iio: imu: st_lsm6dsx: support open drain mode
      dt-bindings: iio: accel: add LIS3L02DQ sensor device binding
      iio: accel: st_accel_spi: add OF capability to st_accel_spi
      iio: magnetometer: st_magn_spi: add OF capability to st_magn_spi
      iio: gyro: st_gyro_spi: add OF capability to st_gyro_spi
      iio: pressure: st_pressure_spi: add OF capability to st_pressure_spi
      iio: accel: st_accel_i2c: fix i2c_device_id table
      iio: accel: st_accel_spi: add support to H3LIS331DL, LIS331DL, LIS3LV02DL
      iio: accel: st_accel: rename H3LIS331DL_DRIVER_NAME in H3LIS331DL_ACCEL_DEV_NAME
      iio: humidity: hts221: refactor write_with_mask code
      iio: humidity: hts221: move BDU configuration in probe routine
      iio: humidity: hts221: do not overwrite reserved data during power-down
      iio: humidity: hts221: avoid useless ODR reconfiguration
      iio: humidity: hts221: squash hts221_power_on/off in hts221_set_enable
      iio: humidity: hts221: support active-low interrupts
      dt-bindings: iio: humidity: hts221: support active-low interrupts
      iio: humidity: hts221: support open drain mode
      dt-bindings: iio: humidity: hts221: support open drain mode
      iio: humidity: hts221: move drdy enable logic in hts221_trig_set_state()

Manivannan Sadhasivam (6):
      iio: temperature: tsys01: Add OF match table
      dt-bindings: iio: temperature: Add bindings for TSYS01 temperature sensor
      iio: humidity: htu21: Add OF match table
      dt-bindings: iio: humidity: Add bindings for HTU21 and MS8607 sensors
      iio: pressure: ms5637: Add OF match table
      dt-bindings: iio: pressure: Add bindings for MS5637, MS5805, MS5837 and MS8607 sensors

Matthias Kaehlcke (1):
      iio: magnetometer: Only declare ACPI table when ACPI is enable

Michael Stecklein (3):
      dt-bindings: iio: humidity: add bindings for HDC100x sensors
      iio: humidity: hdc100x: document compatible HDC10xx devices
      iio: humidity: hdc100x: add match table and device id's

Mike Looijmans (1):
      iio: Add LTC2471/LTC2473 driver

Mikko Koivunen (1):
      iio: light: rpr0521 triggered buffer

Narcisa Ana Maria Vasile (1):
      iio: chemical: ccs811: Add support for AMS CCS811 VOC sensor

Reno Farnesi (2):
      iio: sca3000: Remove trailing whitespace
      iio: adis16400: Change unsigned to unsigned int

Rob Herring (1):
      iio: Convert to using %pOF instead of full_name

Stefan Brüns (2):
      iio: adc: Fix polling of INA219 conversion ready flag
      iio: Documentation: Add missing documentation for power attribute

Zhiyong Tao (3):
      dt-bindings: adc: mt7622: add binding document
      iio: adc: mt7622: add support for suspend/resume.
      iio: adc: mt7622: Add compatible node for mt7622.

 Documentation/ABI/testing/sysfs-bus-iio            |   9 +
 .../bindings/iio/adc/at91-sama5d2_adc.txt          |   6 +
 .../devicetree/bindings/iio/adc/mt6577_auxadc.txt  |   1 +
 .../devicetree/bindings/iio/dac/st,stm32-dac.txt   |   4 +-
 .../devicetree/bindings/iio/humidity/hdc100x.txt   |  17 +
 .../devicetree/bindings/iio/humidity/hts221.txt    |  11 +-
 .../devicetree/bindings/iio/humidity/htu21.txt     |  13 +
 .../devicetree/bindings/iio/imu/st_lsm6dsx.txt     |   8 +
 .../devicetree/bindings/iio/pressure/ms5637.txt    |  17 +
 .../devicetree/bindings/iio/st-sensors.txt         |   2 +
 .../devicetree/bindings/iio/temperature/tsys01.txt |  19 +
 .../bindings/iio/timer/stm32-timer-trigger.txt     |   2 +-
 Documentation/iio/ep93xx_adc.txt                   |  29 +
 drivers/iio/accel/bmc150-accel-i2c.c               |   1 +
 drivers/iio/accel/da311.c                          |   2 +-
 drivers/iio/accel/sca3000.c                        |   6 +-
 drivers/iio/accel/st_accel.h                       |   5 +-
 drivers/iio/accel/st_accel_core.c                  |   2 +-
 drivers/iio/accel/st_accel_i2c.c                   |   8 +-
 drivers/iio/accel/st_accel_spi.c                   |  86 ++-
 drivers/iio/adc/Kconfig                            |  32 +-
 drivers/iio/adc/Makefile                           |   3 +
 drivers/iio/adc/ad7766.c                           |   6 +-
 drivers/iio/adc/at91-sama5d2_adc.c                 | 329 +++++++++-
 drivers/iio/adc/at91_adc.c                         |   2 +-
 drivers/iio/adc/dln2-adc.c                         | 722 +++++++++++++++++++++
 drivers/iio/adc/ep93xx_adc.c                       | 255 ++++++++
 drivers/iio/adc/ina2xx-adc.c                       |  36 +-
 drivers/iio/adc/ltc2471.c                          | 160 +++++
 drivers/iio/adc/ltc2497.c                          |  54 +-
 drivers/iio/adc/max9611.c                          |   4 +-
 drivers/iio/adc/mcp3422.c                          |   6 +-
 drivers/iio/adc/meson_saradc.c                     |  13 +-
 drivers/iio/adc/mt6577_auxadc.c                    |  37 ++
 drivers/iio/adc/rockchip_saradc.c                  |   5 +
 drivers/iio/adc/stm32-adc-core.c                   |   2 +-
 drivers/iio/adc/ti-ads1015.c                       |  16 +-
 drivers/iio/chemical/Kconfig                       |   7 +
 drivers/iio/chemical/Makefile                      |   1 +
 drivers/iio/chemical/ccs811.c                      | 339 ++++++++++
 drivers/iio/common/st_sensors/st_sensors_core.c    |  31 +
 drivers/iio/common/st_sensors/st_sensors_i2c.c     |  29 -
 drivers/iio/dac/stm32-dac-core.c                   |  38 +-
 drivers/iio/dac/stm32-dac.c                        |   2 +-
 drivers/iio/gyro/mpu3050-core.c                    |  10 -
 drivers/iio/gyro/st_gyro.h                         |   1 +
 drivers/iio/gyro/st_gyro_core.c                    |  13 +-
 drivers/iio/gyro/st_gyro_i2c.c                     |   8 +-
 drivers/iio/gyro/st_gyro_spi.c                     |  54 ++
 drivers/iio/humidity/Kconfig                       |   3 +-
 drivers/iio/humidity/hdc100x.c                     |  22 +
 drivers/iio/humidity/hts221.h                      |  11 +-
 drivers/iio/humidity/hts221_buffer.c               |  43 +-
 drivers/iio/humidity/hts221_core.c                 | 144 ++--
 drivers/iio/humidity/htu21.c                       |   8 +
 drivers/iio/imu/adis16400_core.c                   |   4 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c     |  17 +
 drivers/iio/inkern.c                               |   6 +-
 drivers/iio/light/rpr0521.c                        | 336 +++++++++-
 drivers/iio/light/tcs3472.c                        |   4 +-
 drivers/iio/magnetometer/ak8975.c                  |   2 +
 drivers/iio/magnetometer/st_magn_core.c            |   2 +-
 drivers/iio/magnetometer/st_magn_i2c.c             |   3 +-
 drivers/iio/magnetometer/st_magn_spi.c             |  25 +
 drivers/iio/orientation/hid-sensor-rotation.c      |   2 +-
 drivers/iio/pressure/ms5637.c                      |  12 +-
 drivers/iio/pressure/st_pressure_i2c.c             |   3 +-
 drivers/iio/pressure/st_pressure_spi.c             |  33 +
 drivers/iio/pressure/zpa2326.c                     |  12 +-
 drivers/iio/temperature/tsys01.c                   |   7 +
 drivers/staging/iio/adc/ad7280a.c                  |  21 +-
 drivers/staging/iio/light/tsl2x7x.c                | 372 +++++------
 include/linux/iio/common/st_sensors.h              |  12 +
 include/linux/iio/common/st_sensors_i2c.h          |  10 -
 74 files changed, 3098 insertions(+), 479 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/humidity/hdc100x.txt
 create mode 100644 Documentation/devicetree/bindings/iio/humidity/htu21.txt
 create mode 100644 Documentation/devicetree/bindings/iio/pressure/ms5637.txt
 create mode 100644 Documentation/devicetree/bindings/iio/temperature/tsys01.txt
 create mode 100644 Documentation/iio/ep93xx_adc.txt
 create mode 100644 drivers/iio/adc/dln2-adc.c
 create mode 100644 drivers/iio/adc/ep93xx_adc.c
 create mode 100644 drivers/iio/adc/ltc2471.c
 create mode 100644 drivers/iio/chemical/ccs811.c
