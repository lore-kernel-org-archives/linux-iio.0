Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:34906 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751616AbdAKRr5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 11 Jan 2017 12:47:57 -0500
To: Greg KH <gregkh@linuxfoundation.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: [PULL] First set of IIO new device support and cleanups for the 4.11
 cycle.
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <989c2074-b5c4-68ad-36f0-a3c743fdac3d@kernel.org>
Date: Wed, 11 Jan 2017 17:47:55 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following changes since commit af8bc2fb99d4eea2d026d42db18abc5f3876936a:

  staging: unisys: visorbus: Remove two passthrough postcode macros (2016-12-01 09:58:48 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-4.11a

for you to fetch changes up to e30eca0e69cb888125b081c96ca761e958fcb5b4:

  iio:adc:qcom-spmi-vadc: use div64_s64 instead of direct 64 bit division. (2017-01-10 21:13:39 +0000)

----------------------------------------------------------------
First round of new device support, features and cleanups for IIO in the 4.11 cycle.

It's shaping to be another fairly busy cycle. Lots more on the way!

New device support
* ads7950
  - new driver supporting ads7950, ads7951, ads7952, ads7953, ads7954,
  ads7955, ads7956, ads7957, ads7958, ads7959, ads7960, and ads7961 ADCs.
* cm3605
  - New driver for this light sensor and proximity sensor  which is an
  analog part with some additional digital controls.
* hx711
  - New driver.

Core new stuff
* Gravity sensor type.  This is a processed datastream in which the device
will try to work out which way is down.
* Split the buffer.h file into two parts. One provides the interface to 'use'
a buffer, the second provides the internals of the buffer functionality as
needed by implementations of buffers.
  - Move documentation inline so as to allow use of private: tag when
  generating documentation.
  - Add some utility functions for the few things that are directly done
  with the buffers.
  - Stop exporting functions that no-one uses outside of the core code.
  - Push docs down by the code in the c file where they should have always
  been.
  - Fix typo in kernel-doc for buffer.
  - push down some includes that were previously happening implicitly.
  - stop enabling the timestamp of the dummy device.

Features and cleanups
* ad5592r
  - ACPI support
* ad5593r
  -ACPI support.
* ad5933
  - Fix a false comment about size of a particular register.
* ad7150
  - replace S_IRUGO | S_IWUSR with 0644.  I'm not that keen on these patches
  in general, but as it was nicely presented I took this one anyway. As a
  general rule will only take these as part of a larger driver cleanup.
  - don't eat an error but rather reutnr it in the write_event_config callback.
* ad7606
  - replace non standard range attibute with _scale
* ade7753
  - use usleep_range for short sleeps
* ade7754
  - use usleep_range for short sleeps
* ade7758
  - use usleep_range for short sleeps
* ade7759
  - use usleep_range for short sleeps
* ade7854
  - use usleep_range for short sleeps
* adis16201
  - fix description
* adis16203
  - fix description
  - fix copyright year
* adis16209
  - fix description
* adt7316
  - Add braces to arms of if else statement (for consistency)
  - Alignment fixes.
* axp288
  - Fix up an issue with accidental overwrites of data.
* bmi160
  - add deivce tables for i2c and spi to support correctly identifying the
  full dt name (including manufacturer).
  - device tree binding.
* bmp280
  - use usleep_range for short sleeps.
* cm3232
  - return error from cm3232_reg_init rather than eating it if the last write
  fails.
* dummy driver
  - remove a semicolor found at end of a function defintition.
* exynos-adc
  - use usleep_range for short sleeps.
* hid-sensor (accel)
  - Add timestamp support.  The hardware can provide timestamps so lets support
  them. If not fall back to timestamps estimated in kernel.
* hid-sensor (light)
  - Add a duplicate ID for the light channels so as to keep existing interface
  whilst also using the more standard IIO interface.
* hts221
  - acpi probing
* imx25-gcq
  - Add a macro call to allow this driver to be automatically loaded.
* isl29028
  - reorganise code to avoid deep nesting of if statements.
  - move chip test and default regs into a function suitable or sharing with
  power management code.
  - tidy up some code alignment.
* lidar-lite-v3
  - introduce compatible strings that make it clear Garmin have consideral
  friends.
* mma8452
  - avoid returning signed value when unsigned is appropriate
* spmi-vadc
  - Update function for generic voltage conversion to take into account that
  different channels on this device should be handled differently.
  - Rework code to allow per channel voltage scaling and support the standard
  options for this hardware.
  - Fixup three minor issues with the above patches for this part. These all
  effect test builds rather than the native builds for the part, but good to
  clean them up anyway.
* st_sensors
  - support device matching from the ACPI DST tables.
  - acpi based probing for accelerometers
  - acpi based probing for pressure sensors
  - Allow pressure sensors to read negative values.
  - Export sampling frequency for lps25h and lps331ap.
  - Add support for the old DT bindings from the period when these deivces
  were often supported through windows.

Docs fixup:
* typo in sysfs-bus-iio

----------------------------------------------------------------
Amit Kumar Kushwaha (1):
      staging: iio: replace symbolic permission

Andreas Klinger (2):
      iio: adc: hx711: Add DT binding for avia,hx711
      iio: adc: hx711: Add IIO driver for AVIA HX711

Aniroop Mathur (1):
      IIO: Change msleep to usleep_range for small msecs

Brian Masney (3):
      staging: iio: isl29028: remove nested if statements
      staging: iio: isl29028: remove chip test and defaults from isl29028_chip_init()
      staging: iio: isl29028: made alignment of #defines consistent

Colin Ian King (1):
      iio: Documentation: fix spelling mistake: "deactived" -> "deactivated"

David Lechner (1):
      iio: adc: New driver for TI ADS7950 chips

Eva Rachel Retuya (1):
      staging: iio: ad7606: replace range/range_available with corresponding scale

Hans de Goede (1):
      iio: adc: axp288: Drop bogus AXP288_ADC_TS_PIN_CTRL register modifications

Javier Martinez Canillas (1):
      iio: adc: imx25-gcq: Fix module autoload

Jonathan Cameron (14):
      iio:buffer: Stop exporting iio_update_demux
      iio:buffer.h Reformat structure comments to be inline.
      iio:buffer: Introduced a function to assign the buffer specific attrs.
      iio:buffer: Stop exporting iio_scan_mask_query
      iio:buffers: Push some docs down into the .c file.
      iio:buffer:iio_push_to_buffers_with_timestamp fix kernel-doc.
      iio:kfifo_buf header include push down.
      iio:buffer.h include pushdown into buffer implementations
      iio:buffer: Push implementation of iio_device_attach_buffer into .c file
      iio:dummy: Stop enabling timestamp by default.
      iio:buffer.h - split into buffer.h and buffer_impl.h
      iio:adc:qcom-spmi-vadc : fix undefined __divdi3
      iio:adc:qcom-spmi-vadc silence a long constant warning.
      iio:adc:qcom-spmi-vadc: use div64_s64 instead of direct 64 bit division.

Kweh, Hock Leong (1):
      iio: light: hid-sensor-als: Add duplicate IIO_LIGHT channel

Linus Walleij (3):
      iio: light: add DT bindings for Capella CM3605
      iio: light: add driver for Capella CM3605
      iio: accel: st_accel: handle deprecated bindings

Marcin Niestroj (5):
      iio: bmi160: Add of device table for i2c
      iio: bmi160: Add of device table for spi
      Documentation: DT: Add bmi160 imu binding
      iio: st_pressure: Fix data sign
      iio: st_pressure: Export sampling frequency for lps25h and lps331ap

Martin Kepplinger (1):
      iio: accel: mma8452: define unsigned return values where appropriate

Matt Ranostay (2):
      devicetree: add Garmin vendor prefix
      iio: pulsedlight-lidar-lite-v2: add lidar-lite-v3 property

Michael Hennerich (2):
      iio: dac: ad5592r: Add ACPI support
      iio: dac: ad5593r: Add ACPI support

Nizam Haider (1):
      Staging: iio: impedance-analyzer: ad5933: fix wrong comments

Pan Bian (2):
      iio: light: fix improper return value
      staging: iio: cdc: fix improper return value

Peter Meerwald-Stadler (1):
      iio: dummy: No semicolon at end of function definition

Rama Krishna Phani A (2):
      iio: adc: spmi-vadc: Update function for generic voltage conversion
      iio: adc: spmi-vadc: Changes to support different scaling

Reto Schneider (2):
      iio: adis1620x: Fix mixed up device descriptions
      iio: adis16203: Fix copyright year

Scott Matheina (2):
      staging:iio:adt7316: Fix braces not present on all arms of if else statement
      staging:iio:addac:adt7316 Fixes Alignment should match open parenthesis

Shrirang Bagul (4):
      iio: st_sensors: match sensors using ACPI handle
      iio: st_accel: Support sensor i2c probe using acpi
      iio: st_pressure: Support i2c probe using acpi
      iio: humidity: Support acpi probe for hts211

Song Hongyan (2):
      iio: Add channel for Gravity
      iio: Add gravity sensor support

Srinivas Pandruvada (1):
      iio: accel: hid-sensor-accel-3d: Add timestamp

rishabh hardas (1):
      iio:trigger: Fix coding style in iio-trig-bfin-timer.c by aligning parameters with opening bracket.

 Documentation/ABI/testing/sysfs-bus-iio            |  12 +-
 .../devicetree/bindings/iio/accel/lis302.txt       |   2 +-
 .../devicetree/bindings/iio/adc/avia-hx711.txt     |  18 +
 .../devicetree/bindings/iio/imu/bmi160.txt         |  36 ++
 .../devicetree/bindings/iio/light/cm3605.txt       |  41 ++
 .../devicetree/bindings/iio/st-sensors.txt         |   2 +
 .../devicetree/bindings/vendor-prefixes.txt        |   2 +
 drivers/iio/accel/Kconfig                          |   2 +
 drivers/iio/accel/bmc150-accel-core.c              |   3 +-
 drivers/iio/accel/hid-sensor-accel-3d.c            | 104 +++-
 drivers/iio/accel/mma8452.c                        |   4 +-
 drivers/iio/accel/ssp_accel_sensor.c               |   1 +
 drivers/iio/accel/st_accel.h                       |  18 +
 drivers/iio/accel/st_accel_i2c.c                   |  78 ++-
 drivers/iio/accel/st_accel_spi.c                   |   9 +
 drivers/iio/adc/Kconfig                            |  32 ++
 drivers/iio/adc/Makefile                           |   2 +
 drivers/iio/adc/axp288_adc.c                       |  32 +-
 drivers/iio/adc/exynos_adc.c                       |   2 +-
 drivers/iio/adc/fsl-imx25-gcq.c                    |   1 +
 drivers/iio/adc/hx711.c                            | 532 +++++++++++++++++++++
 drivers/iio/adc/ina2xx-adc.c                       |   2 +
 drivers/iio/adc/qcom-spmi-vadc.c                   | 481 ++++++++++++++-----
 drivers/iio/adc/ti-ads7950.c                       | 490 +++++++++++++++++++
 drivers/iio/buffer/industrialio-buffer-cb.c        |   3 +-
 drivers/iio/buffer/kfifo_buf.c                     |   3 +
 .../iio/common/hid-sensors/hid-sensor-attributes.c |  36 +-
 drivers/iio/common/ssp_sensors/ssp_iio.c           |   1 +
 drivers/iio/common/st_sensors/st_sensors_i2c.c     |  20 +
 drivers/iio/dac/ad5592r.c                          |   8 +
 drivers/iio/dac/ad5593r.c                          |   8 +
 drivers/iio/dummy/iio_simple_dummy.h               |   8 +-
 drivers/iio/dummy/iio_simple_dummy_buffer.c        |   4 +-
 drivers/iio/gyro/ssp_gyro_sensor.c                 |   1 +
 drivers/iio/humidity/hts221_i2c.c                  |   8 +
 drivers/iio/imu/bmi160/bmi160_i2c.c                |  14 +-
 drivers/iio/imu/bmi160/bmi160_spi.c                |  18 +-
 drivers/iio/industrialio-buffer.c                  | 321 +++++++------
 drivers/iio/industrialio-core.c                    |   2 +
 drivers/iio/light/Kconfig                          |  10 +
 drivers/iio/light/Makefile                         |   1 +
 drivers/iio/light/cm3232.c                         |   2 +-
 drivers/iio/light/cm3605.c                         | 330 +++++++++++++
 drivers/iio/light/hid-sensor-als.c                 |  24 +-
 drivers/iio/pressure/bmp280-core.c                 |  14 +-
 drivers/iio/pressure/st_pressure.h                 |   8 +
 drivers/iio/pressure/st_pressure_core.c            |  12 +-
 drivers/iio/pressure/st_pressure_i2c.c             |  51 +-
 drivers/iio/proximity/pulsedlight-lidar-lite-v2.c  |   2 +
 drivers/staging/iio/accel/adis16201_core.c         |   4 +-
 drivers/staging/iio/accel/adis16203_core.c         |   6 +-
 drivers/staging/iio/accel/adis16209_core.c         |   4 +-
 drivers/staging/iio/adc/ad7606.c                   |  79 ++-
 drivers/staging/iio/addac/adt7316-i2c.c            |   2 +-
 drivers/staging/iio/addac/adt7316.c                |   3 +-
 drivers/staging/iio/cdc/ad7150.c                   |   4 +-
 drivers/staging/iio/impedance-analyzer/ad5933.c    |   4 +-
 drivers/staging/iio/light/isl29028.c               | 114 ++---
 drivers/staging/iio/meter/ade7753.c                |   2 +-
 drivers/staging/iio/meter/ade7753.h                |   2 +-
 drivers/staging/iio/meter/ade7754.c                |   2 +-
 drivers/staging/iio/meter/ade7754.h                |   2 +-
 drivers/staging/iio/meter/ade7758.h                |   2 +-
 drivers/staging/iio/meter/ade7758_core.c           |   2 +-
 drivers/staging/iio/meter/ade7758_ring.c           |   1 +
 drivers/staging/iio/meter/ade7759.c                |   2 +-
 drivers/staging/iio/meter/ade7759.h                |   2 +-
 drivers/staging/iio/meter/ade7854.c                |   2 +-
 drivers/staging/iio/meter/ade7854.h                |   2 +-
 drivers/staging/iio/trigger/iio-trig-bfin-timer.c  |   2 +-
 include/linux/hid-sensor-hub.h                     |   4 +
 include/linux/hid-sensor-ids.h                     |   4 +
 include/linux/iio/buffer.h                         | 160 +------
 include/linux/iio/buffer_impl.h                    | 162 +++++++
 include/linux/iio/common/st_sensors_i2c.h          |   9 +
 include/linux/iio/kfifo_buf.h                      |   5 +-
 include/uapi/linux/iio/types.h                     |   1 +
 tools/iio/iio_event_monitor.c                      |   2 +
 78 files changed, 2725 insertions(+), 680 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/avia-hx711.txt
 create mode 100644 Documentation/devicetree/bindings/iio/imu/bmi160.txt
 create mode 100644 Documentation/devicetree/bindings/iio/light/cm3605.txt
 create mode 100644 drivers/iio/adc/hx711.c
 create mode 100644 drivers/iio/adc/ti-ads7950.c
 create mode 100644 drivers/iio/light/cm3605.c
 create mode 100644 include/linux/iio/buffer_impl.h
