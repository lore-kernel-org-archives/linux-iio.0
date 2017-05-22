Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:37404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933151AbdEVU0Q (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 22 May 2017 16:26:16 -0400
Date: Mon, 22 May 2017 21:26:12 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: gregkh@linuxfoundation.org, linux-iio@vger.kernel.org
Subject: [PULL] First set of new device support, features and cleanups for
 IIO in the 4.13 cycle.
Message-ID: <20170522212612.4b50d744@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following changes since commit e44adf05b85e5a9d1d224f5ecde1c1c5e5371e36:

  staging/android: Update Ion TODO list (2017-04-18 20:43:14 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-4.13a

for you to fetch changes up to 7e87d11c9bda75816ced8d0895e8d24e5c52833a:

  iio: adc: Add support for TI ADC108S102 and ADC128S102 (2017-05-21 15:11:14 +0100)

----------------------------------------------------------------
First set of new device support, features and cleanups for IIO in the 4.13 cycle

Two entirely new drivers in here plus the usual range of cleanups and features.

New device support
* ad5064
  - add ltc2631, ltc2633 and ltc2635 support.
* bma180
  - trivial support for bma250e (new id)
* hid-sensor-rotation
  - add relative orientation and geometric orientation support.
* isl29028
  - add isl29030 support (its effectively the same part from a driver point of
  view)
* maxim_thermocouple
  - add max31856 id.
* meson-saradc
  - add meson8b SoC adc support.
* ti-adc084s021
  - new driver and bindings.
* ti-adc108s102
  - new driver and bindings.

Staging graduations
* isl29028

Features
* bma180
  - ACPI enumeration for BMA250E which is used in various x86 tablets.
* hi8453
  - add raw access rather than only events.
* hid-sensor-hub
  - Implement batch mode in which we can set a threshold on the amount of time
  between data coming from the fifos.  This is the first device to do this
  rather than use a watershed on the number of samples.
* hts221
  - power management support
* lsm6dsx
  - add system power management support.
* rpr0521
  - sampling frequency read / write
* stm32-trigger
  - add support for TRG02 triggers.
* tsl2583
  - runtime power management support.

Cleanups
* core
  - inkern: fix a double unlock in iio_read_available_channel_raw when raw
  value doesn't appear to be raw (error path).
  - fixup accidental sizeof pointer in iio_device_add_mask_type.
* docs
  - fix an accidental duplicated line in sysfs-bus-iio-meas-spec.
* tools
  - use local include/uapi headers to ensure always up to date.
  - increase length of allowed trigger names.
* ad9834
  - symbolic to octal permissions.
* ade7753
  - symbolic to octal permissions.
  - fix indentation
* ade7754
  - symbolic to octal permissions.
* ade7758
  - symbolic to octal permissions.
- ade7854
  - symbolic to octal permissions.
* as3935
  - move out of storm check to given consistent results for raw and processed
  values.
* bmp280
  - fix bme280 naming in Kconfig help.
* hi8435
  - avoid garbage on event after enable.
  - add missing in_voltage_sensing_mode_available to list possible enum options.
  - handle the reset gpio with the obvious polarity rather than relying on
  DT to provide it correctly.
* hid-sensors
  - fix a wrong error path scrubbing of return values.
* hid-sensors-accel
  - drop static on a local variable
* hid-sensors-rotation
  - Add missing scale and offset property parsing support.
* ina2xx
  - Fix a bad use of GENMASK and some typos and whitespace issues.
* isl29018
  - only declare the ACPI table when ACPI is enabled.
* isl29028
  - fix proximity sleep times.
* lsm6dsx
  - replace ifdef CONFIG_PM with __maybe_unused to avoid the complexity of
  dealing with the various PM config variables.
* meson-saradc
  - mark meson_sar_adc_data static and const.
* rcar-gyroadc
  - derive the interface clock speed from the fck clock on the basis they are
  the same actual clock.
  - drop the now unused if clock from the bindings.
* rpr0521
  - disable sensor when marked as such rather than always enabling it.
  - poweroff if probe fails and we can talk to device.
  - make sure device powered off when it doesn't need to be on.
  - use sizeof rather than hardcoded size on value read.
  - whitespace fixup.
  - reorder channel numbers ready for buffered support which didn't quite
  make this pull request.
* st-accel
  - fix platform data initialization to allow remove and reprobe.
* st-pressure
  - fix platform data initialization to allow remove and reprobe.
* tsl2x7x
  - S_IRUGO, S_IWUSR to octal values
  - rename driver for consistency with more recent drivers
  - drop FSF mailing address
  - replace DEVICE_ATTR macros with the shorter DEVICE_ATTR_RW form and
  relevant function renames.
* zpa2326
  - report an error for consistency with other error paths.

----------------------------------------------------------------
Brian Masney (4):
      staging: iio: isl29028: correct proximity sleep times
      staging: iio: isl29028: move out of staging
      staging: iio: tsl2x7x: rename driver for consistency with other IIO light drivers
      iio: tsl2583: add runtime power management support

Colin Ian King (1):
      iio: hid-sensor: fix return of -EINVAL on invalid values in ret or value

Enric Balletbo i Serra (1):
      tsl2x7x: remove paragraph about writing to the FSF's mailing address

Eugen Hristev (1):
      iio: tools: generic_buffer: increase trigger length

Fabrice Gasnier (1):
      iio: stm32 trigger: Add support for TRGO2 triggers

Hans de Goede (2):
      iio: accel: bma180: Add support for BMA250E
      iio: accel: bma180: Add ACPI enumeration support for BMA250E

Harinath Nampally (1):
      staging: iio: meter: Fix the identations for proper alignments.

Jan Kiszka (1):
      iio: adc: Add support for TI ADC108S102 and ADC128S102

Julia Lawall (1):
      iio: hid-sensor-accel-3d: Drop unnecessary static

Lorenzo Bianconi (4):
      iio: imu: st_lsm6dsx: modify st_lsm6dsx_flush_fifo and st_lsm6dsx_set_fifo_mode scope
      iio: imu: st_lsm6dsx: add system power management support
      iio: humidity: hts221: add power management support
      iio: imu: st_lsm6dsx: substitute ifdef CONFIG_PM with __maybe_unused macro

Marek Vasut (2):
      iio: adc: rcar-gyroadc: Derive interface clock speed from fck clock
      iio: adc: rcar-gyroadc: Drop if clock from Renesas GyroADC bindings

Martin Blumenstingl (3):
      iio: adc: meson-saradc: mark all meson_sar_adc_data static and const
      dt-bindings: iio: adc: add Meson8 and Meson8b support
      iio: adc: meson-saradc: add Meson8b SoC compatibility

Matt Ranostay (2):
      iio: proximity: as3935: move storm out of range check
      iio: temperature: maxim_thermocouple: add MAX31856 part

Matthias Kaehlcke (1):
      iio: light: isl29018: Only declare ACPI table when ACPI is enabled

Mike Looijmans (1):
      iio:ad5064: Add support for ltc2633 and similar devices

Mikko Koivunen (8):
      iio: light: rpr0521 disable sensor -bugfix
      iio: light: rpr0521 poweroff for probe fails
      iio: light: rpr0521 on-off sequence change for CONFIG_PM
      iio: light: rpr0521 magic number to sizeof() on value read
      iio: light: rpr0521 whitespace fixes
      iio: light: rpr0521 sample_frequency read/write
      iio: light: rpr0521 proximity offset read/write
      iio: light: rpr0521 channel numbers reordered

Mårten Lindahl (2):
      dt-bindings: iio: adc: add driver for the ti-adc084s021 chip
      iio: adc: add driver for the ti-adc084s021 chip

Nicholas Mc Guire (1):
      iio: pressure: zpa2326: report interrupted case as failure

Nikita Yushchenko (4):
      iio: hi8435: add raw access
      iio: hi8435: avoid garbage event at first enable
      iio: hi8435: make in_voltage_sensing_mode_available visible
      iio: hi8435: cleanup reset gpio

Orson Zhai (1):
      iio: core: Fix suspicious sizeof usage

Paolo Cretaro (1):
      staging: iio: tsl2x7x: Replace deprecated macros (S_IRUGO, S_IWUSR)

Peter Meerwald-Stadler (1):
      iio: pressure: Fix name of BME280 part in Kconfig

Peter Rosin (1):
      iio: inkern: fix a static checker error

Quentin Swain (5):
      iio: ad9834 convert symbolic permissions to octal
      iio: ade7753 Convert: symbolic permissions to octal
      iio: ade7754: Convert symbolic permissions to octal
      iio: ade7758: Convert symbolic permissions to octal
      iio: ade7854: Convert symbolic permissions to octal

Sebastian Reichel (1):
      iio: isl29028: add isl29030 support

Sekhar Nori (1):
      tools/iio: Use include/uapi with __EXPORTED_HEADERS__

Shrirang Bagul (1):
      iio: st_pressure: st_accel: Initialise sensor platform data properly

Song Hongyan (3):
      iio: hid-sensor-rotation: Add relative orientation sensor hid support
      iio: hid-sensor-rotation: Add geomagnetic orientation sensor hid support.
      iio: hid-sensor-rotation: Add "scale" and "offset" properties parse support

Srinivas Pandruvada (1):
      iio: hid-sensor-hub: Implement batch mode

Stefan Brüns (2):
      iio: Documentation: sysfs-bus-iio-meas-spec: Remove (partially) duplicate line
      iio: adc: Fix bad GENMASK use, typos, whitespace

Surender Polsani (1):
      staging: iio: light: Replace symbolic permissions as per coding style

 Documentation/ABI/testing/sysfs-bus-iio            |  11 +
 Documentation/ABI/testing/sysfs-bus-iio-meas-spec  |   1 -
 .../ABI/testing/sysfs-bus-iio-timer-stm32          |  48 +++
 .../devicetree/bindings/i2c/trivial-devices.txt    |   1 +
 .../bindings/iio/adc/amlogic,meson-saradc.txt      |   2 +
 .../bindings/iio/adc/renesas,gyroadc.txt           |   7 +-
 .../devicetree/bindings/iio/adc/ti-adc084s021.txt  |  19 ++
 .../devicetree/bindings/iio/adc/ti-adc108s102.txt  |  18 ++
 drivers/iio/accel/bma180.c                         |  45 ++-
 drivers/iio/accel/hid-sensor-accel-3d.c            |   2 +-
 drivers/iio/accel/st_accel_core.c                  |   7 +-
 drivers/iio/adc/Kconfig                            |  24 ++
 drivers/iio/adc/Makefile                           |   2 +
 drivers/iio/adc/hi8435.c                           |  50 ++-
 drivers/iio/adc/ina2xx-adc.c                       |  12 +-
 drivers/iio/adc/meson_saradc.c                     |  86 +++--
 drivers/iio/adc/rcar-gyroadc.c                     |  16 +-
 drivers/iio/adc/ti-adc084s021.c                    | 275 ++++++++++++++++
 drivers/iio/adc/ti-adc108s102.c                    | 348 +++++++++++++++++++++
 .../iio/common/hid-sensors/hid-sensor-attributes.c |  54 +++-
 .../iio/common/hid-sensors/hid-sensor-trigger.c    |  80 +++++
 drivers/iio/dac/Kconfig                            |   3 +-
 drivers/iio/dac/ad5064.c                           |  71 ++++-
 drivers/iio/humidity/hts221.h                      |   3 +
 drivers/iio/humidity/hts221_core.c                 |  54 +++-
 drivers/iio/humidity/hts221_i2c.c                  |   1 +
 drivers/iio/humidity/hts221_spi.c                  |   1 +
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h            |   5 +
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c     |   6 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c       |  52 +++
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c        |   1 +
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c        |   1 +
 drivers/iio/industrialio-core.c                    |   4 +-
 drivers/iio/inkern.c                               |   4 +-
 drivers/iio/light/Kconfig                          |  10 +
 drivers/iio/light/Makefile                         |   1 +
 drivers/iio/light/isl29018.c                       |   2 +
 drivers/{staging => }/iio/light/isl29028.c         |  76 +++--
 drivers/iio/light/rpr0521.c                        | 307 +++++++++++++++---
 drivers/iio/light/tsl2583.c                        | 106 +++++--
 drivers/iio/orientation/hid-sensor-rotation.c      |  55 +++-
 drivers/iio/pressure/Kconfig                       |   2 +-
 drivers/iio/pressure/st_pressure_core.c            |   8 +-
 drivers/iio/pressure/zpa2326.c                     |  18 +-
 drivers/iio/proximity/as3935.c                     |   6 +-
 drivers/iio/temperature/maxim_thermocouple.c       |   1 +
 drivers/iio/trigger/stm32-timer-trigger.c          | 113 ++++++-
 drivers/staging/iio/frequency/ad9834.c             |  22 +-
 drivers/staging/iio/frequency/dds.h                |   2 +-
 drivers/staging/iio/light/Kconfig                  |  10 -
 drivers/staging/iio/light/Makefile                 |   3 +-
 .../iio/light/{tsl2x7x_core.c => tsl2x7x.c}        |  66 ++--
 drivers/staging/iio/meter/ade7753.c                | 101 +++---
 drivers/staging/iio/meter/ade7754.c                |  56 ++--
 drivers/staging/iio/meter/ade7758_core.c           |  50 +--
 drivers/staging/iio/meter/ade7854.c                |  88 +++---
 include/linux/hid-sensor-hub.h                     |   5 +
 include/linux/hid-sensor-ids.h                     |   5 +
 include/linux/iio/timer/stm32-timer-trigger.h      |   2 +
 include/linux/mfd/stm32-timers.h                   |   2 +
 tools/iio/Makefile                                 |   2 +-
 tools/iio/iio_utils.h                              |   2 +-
 62 files changed, 2010 insertions(+), 425 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/ti-adc084s021.txt
 create mode 100644 Documentation/devicetree/bindings/iio/adc/ti-adc108s102.txt
 create mode 100644 drivers/iio/adc/ti-adc084s021.c
 create mode 100644 drivers/iio/adc/ti-adc108s102.c
 rename drivers/{staging => }/iio/light/isl29028.c (89%)
 rename drivers/staging/iio/light/{tsl2x7x_core.c => tsl2x7x.c} (95%)
